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
        return {
            status: 401
        };
    }

    console.log(`changing clearance for ${data.email} to ${data.clearance}`);

    // getting the email of the user who's clearance should be updated
    const email = data.email;

    // getting clearance level to be set
    const clearance = data.clearance;

    try {
        // getting user from firebase
        const user = await admin.auth().getUserByEmail(email);

        // setting the clearance level
        await admin.auth().setCustomUserClaims(user.uid, {
            clearance: clearance
        });
    } catch (err) {
        console.log(err);
        return {
            status: 500
        };
    }

    return {
        status: 200
    };
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