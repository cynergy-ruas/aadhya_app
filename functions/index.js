const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();
db.settings({
    timestampsInSnapshots: true
});


/**
 * Function to update the clearance level of a user.
 */
exports.updateClearance = functions.https.onCall(async (data, context) => {
    console.log(`request initiated by: ${context.auth.token.email}`);

    // checking if the user attempting to change the clearance has permissions
    if (context.auth.token.clearance < 1) {
        console.log(`Attempting to update clearance with insufficient permissions: ${context.auth.token.email}`);
        throw new functions.https.HttpsError(
            'permission-denied', 
            'Attempting to update clearance with insufficient permissions'
        );
    }

    console.log(`changing clearance for ${data.email} to ${data.clearance}`);

    // getting the email of the user who's clearance should be updated
    const email = data.email;

    // getting clearance level to be set
    const newClearance = data.clearance;

    try {
        // getting user from firebase
        const user = await admin.auth().getUserByEmail(email);
        const oldClearance = user.customClaims.clearance;
        
        // getting the claims. The claims are reset if the new clearance level
        // is lower than the old clearance level.
        let claims = {};
        if (user.customClaims !== undefined && newClearance >= oldClearance)
            claims = user.customClaims;

        // adding clearance level to claims
        claims.clearance = newClearance;

        // setting the clearance level
        await admin.auth().setCustomUserClaims(user.uid, claims);
    } catch (err) {
        console.log(err);
        throw new functions.https.HttpsError(
            'internal',
            err.toString()
        );
    }
});

/**
 * Function that assigns level 1 users to events.
 */
exports.assignEventsToUser = functions.https.onCall(async (data, context) => {
    console.log(`request initiated by: ${context.auth.token.email}`);

    // checking if the user attempting to change the clearance has permissions
    if (context.auth.token.clearance < 1) {
        console.log(`Attempting to assign event with insufficient permissions: ${context.auth.token.email}`);
        throw new functions.https.HttpsError(
            'permission-denied', 
            'Attempting to assign event with insufficient permissions'
        );
    }

    console.log(`assigning ${data.eventID} to ${data.email}`);

    try {
        // getting the clearance level of the user
        const user = await admin.auth().getUserByEmail(data.email);

        // assigning event to user only if clearance level is greater than 0
        if (user.customClaims.clearance !== undefined && user.customClaims.clearance !== 0) {
            
            // getting current claims
            const claims = user.customClaims;
            
            // checking if level 1 user is to be assigned management over all events of a department
            if (claims.clearance === 1 && 
                (data.eventID === "ASE" || data.eventID === "CSE" || data.eventID === "ECE" || data.eventID === "DS"
                || data.eventID === "ME" || data.eventID === "ALL")) {
                    console.log(`Invalid request. Cannot assign level 1 user to events: ${data.eventID}`);
                    throw new functions.https.HttpsError(
                        'invalid-argument', 
                        `Cannot assign level 1 user to events: ${data.eventID}`
                    );
                }
            
            // assigning event
            claims.eventID = data.eventID;

            // updating claims
            await admin.auth().setCustomUserClaims(user.uid, claims);
        } else {
            console.log(`user ${data.email} is a level 0 user. Cannot assign event(s).`);
            throw new functions.https.HttpsError(
                'invalid-argument', 
                'Cannot assign level 0 user to an event.',
            );
        }
    } catch (err) {
        console.log(err);
        throw new functions.https.HttpsError(
            'internal',
            err.toString()
        );
    }
});

/**
 * Sends a notification when an event is updated.
 */
exports.notifyUpdatedEvent = functions.firestore.document("/events/{docId}")
    .onUpdate((change, context) => {
        // getting the document data before the change
        const docData = change.before.data();

        // getting the id of the event (id field in document)
        const eventID = docData.id;

        // getting the name of the event (name field in document)
        const eventName = docData.name;

        // logging
        console.log(`sending notification for event ${eventID}`);
        
        // constructing the notification payload
        const payload = constructNotificationPayload({
            title: "Update!",
            body: `There is a change regarding the event ${eventName}`,
            data: {
                eventID: eventID
            },
            topic: eventID
        });
        
        // sending the notification
        return admin.messaging().send(payload)
        .then((response) => {
            console.log(`sent event ${eventID} update notification`);
            return true;
        })
        .catch((error) => {
            console.log(`error sending update notification for ${eventID}`);
            console.log(error);
        });
    });

/**
 * Sends a notification to the topic.
 */

exports.publishNotification = functions.https.onCall(async (data, context) => {
    
    // checking if the user is authorized to send notifications or not
    if (context.auth.token.clearance < 1) {
        console.log(`Attempting to send notification with insufficient permissions: ${context.auth.token.email}`);
        return {
            status: 401
        };
    }

    // logging
    console.log(`sending notification: ${data.title}. Requested by: ${context.auth.token.email}`);

    // constructing payload
    const payload = constructNotificationPayload({
        title: data.title,
        body: data.body,
        data: data.data,
        topic: data.topic
    });

    try {
        // sending the notification
        await admin.messaging().send(payload);

        // logging
        console.log(`sent notification to topic ${data.topic}`);

        // returning ok status code
        return {
            status: 200
        };
    } catch (err) {
        // logging
        console.log(`error sending sending notification to topic ${data.topic}`);
        console.log(error);

        // returning error status code
        return {
            status: 500
        };
    }
});

/**
 * end point that is used to add a registered event to the list of registered events
 * for a user.
 */
exports.updateEventsForUser = functions.https.onRequest(async (req, res) => {
    try {
        
        // updating data

        // townscript api can send an array of dictionaries containing the data.
        // therefore updating the data for all of the given users
        if (Array.isArray(req.body)) {
            req.body.forEach(async (data) => {
                console.log(`received request with email: ${data.userEmailId}`);
                await updateDataForUser({emailid: data.userEmailId, eventCode: data.eventCode})
            });
        }
        else {
            console.log(`received request with email: ${req.body.userEmailId}`);
            await updateDataForUser({emailid: req.body.userEmailId, eventCode: req.body.eventCode});
        }

        // sending status 200 and closing the connection
        res.status(200).send();
    } catch (err) {
        console.log(`error occurred while updating events for user.`);
        console.log(err);

        if (err instanceof TypeError)
            res.status(404).send();
        else
            res.status(500).send();
    }
});

/**
 * Updates the registered events for a user.
 * @param emailid The email id of the user.
 * @param eventCode The event code to be added.
 */
async function updateDataForUser({emailid, eventCode}) {
    // getting reference to user document
    const docRef = db.collection("users").doc(emailid);

    // getting the registered events from the document
    const regEvents = (await docRef.get()).data().regEvents;

    // appending event code from request to `regEvents`
    regEvents.push(eventCode);

    // updating the document
    await docRef.update({
        regEvents: regEvents
    });
}

/**
 * Constructs the notification payload.
 * 
 * @param title The title of the notification.
 * @param body The body of the notification.
 * @param data The data of the notification.
 * @param topic The topic to send to the notification to.
 */
function constructNotificationPayload({title, body, data, topic}) {
    return {
        notification: {
            title: title,
            body: body,
        },
        data: data,
        android: {
            notification: {
                click_action: "FLUTTER_NOTIFICATION_CLICK"
            }
        },
        topic: topic
    };
}