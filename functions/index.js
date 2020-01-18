const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
admin.firestore().settings({
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