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

    // defining user variable
    let user;

    try {
        // getting user from firebase
        try {
            user = await admin.auth().getUserByEmail(email);
        }
        catch (err) {
            user = await admin.auth().createUser({
                email: data.email,
                password: data.email.split("@")[0] + "123"
            });
        }
        const oldClearance = (user.customClaims === undefined) ? -1 : user.customClaims.clearance;
        
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
        if (user.customClaims !== undefined && user.customClaims.clearance !== undefined && user.customClaims.clearance !== 0) {
            
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
        
        // constructing the notification payload for android
        const payload = constructNotificationPayload({
            title: "Update!",
            body: `There is a change regarding the event ${eventName}`,
            data: {
                eventID: eventID
            },
            topic: eventID,
        });
        
        // sending the notification for android and ios
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
        condition: `'${data.eventid}' in topics || '${data.department}' in topics`
    });

    try {
        // sending the notification
        await admin.messaging().send(payload);

        // logging
        console.log(`sent notification to eventid ${data.eventid} of department ${data.department}`);

        // returning ok status code
        return {
            status: 200
        };
    } catch (err) {
        // logging
        console.log(`error sending sending notification to eventid ${data.eventid} of department ${data.department}`);
        console.log(err);

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

    async function updateData({emailid, eventCode, registrationId, answerList}) {
        // checking if the user document exists in users collection, and 
        // creating the same if it does not exist.
        await checkAndCreateUserDocument({emailid: emailid});

        // updating the data for the user
        await updateDataForUser({emailid: emailid, eventCode: eventCode, registrationId: registrationId, answerList: answerList});
    }

    // getting the data from the request
    const body = JSON.parse(req.body.data);

    console.log(`payload: ${JSON.stringify(body)}`);

    // updating data

    // townscript api can send an array of dictionaries containing the data.
    // therefore updating the data for all of the given users
    if (Array.isArray(body)) {
        let statusCode = 200;

        const promises = body.map((data) => {
            console.log(`received request with email: ${data.userEmailId}`);
            return updateData({emailid: data.userEmailId, eventCode: data.eventCode, registrationId: data.registrationId, answerList: data.answerList})
            .catch((err) => {
                statusCode = 202;
                console.log(`error updating events for the user ${data.userEmailId}`);
                return console.log(err);
            });
        });


        await Promise.all(promises)
        res.status(statusCode).send();
    }
    else {

        try {
            console.log(`received request with email: ${body.userEmailId}`);
            await updateData({emailid: body.userEmailId, eventCode: body.eventCode, registrationId: body.registrationId, answerList: body.answerList});
            res.status(200).send();
        }
        catch (err) {
            console.log(err);
            res.status(500).send();
        }
        
    }
});

/**
 * Sets the device token for a user.
 */
exports.setFCMToken = functions.https.onCall(async (data, context) => {
    if (data.token === null) {
        console.log(`received null FCM token from ${data.emailid}, aborting.`);
        return;
    }

    console.log(`setting FCM token for ${data.emailid}`);

    // adding token to document
    await db.collection("users").doc(data.emailid).update({
        deviceToken: data.token
    });
});

/**
 * Checks if the user document exists and if it doesnt, creates the 
 * document.
 * @param emailid The email id of the user.
 */
async function checkAndCreateUserDocument({emailid}) {
    try {
        await db.collection("users").doc(emailid).create({
            regEvents: [],
            regEventIds: [],
            passes: {},
        });
    }
    catch (err) {
        console.log(`Document for ${emailid} exists`);
    }
}

/**
 * Updates the registered events for a user.
 * @param emailid The email id of the user.
 * @param eventCode The event code to be added.
 * @param registrationId The registration id provided by townscript
 * @param answerList The list of answers of the form asked in townscript
 */
async function updateDataForUser({emailid, eventCode, registrationId, answerList}) {
    // getting reference to user document
    const docRef = db.collection("users").doc(emailid);

    // getting the data from document
    const docData = (await docRef.get()).data();

    // getting the registered events from the document
    const regEvents = docData.regEvents;

    // getting the registered event ids (townscript ids)
    const regEventIds = docData.regEventIds;

    // getting the passes from the document
    const passes = docData.passes;

    // checking if the event is a pass or not by getting the pass document using
    // the `eventCode`. If such a document exists, then the event is a pass
    const isPass = ! (await db.collection("passes").where("id", "==", eventCode).get()).empty;

    // if its not a pass, treat it as a normal event
    if (! isPass) {
        // appending event code from request to `regEvents`
        regEvents.push(eventCode);

        // appending registration id from request to `regEventIds`
        regEventIds.push(registrationId);
    } else {
        let value = [];
        answerList.forEach(
            (qa) => value = value.concat(qa["answer"].split(","))
        );

        // if it is a pass, add it to the passes field
        passes[eventCode] = {
            id: registrationId,
            events: value
        };
    }

    // updating the document
    await docRef.update({
        regEvents: regEvents,
        regEventIds: regEventIds,
        passes: passes
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
function constructNotificationPayload({title, body, data, topic, condition, ios}) {

    // checking if topic and token both are given at the same time.
    // if it so, throw an error.
    if (topic !== undefined && condition !== undefined) 
        throw new Error("topic and condition both cannot be specified at the same time.");

    // adding title and body to data field so that `onResume` and `onLaunch` in 
    // the app works
    data.title = title;
    data.body = body;

    // adding id
    data.id = (Date.now() + Math.random()).toString();
    
    // defining setting for sending notification to android devices
    const androidSettings = {
        notification: {
            title: title,
            body: body,
            click_action: "FLUTTER_NOTIFICATION_CLICK"
        },
        data: data
    }

    // defining settings for sending notifications to iOS devices
    const iosSettings = {
        payload: {
            headers: {
                "apns-priority": 10
            },
            aps: {
                alert: {
                    title: title,
                    body: body
                }
            },

            data: data
        }
    }
    
    // the body of the notification
    const payload = {
        apns: iosSettings,
        android: androidSettings
    }

    // adding ios settings if needed
    


    // adding the topic or token, depending on what is given.
    if (condition !== undefined) {
        payload.condition = condition;
    }
    else if (topic !== undefined)
        payload.topic = topic;

    return payload;

}