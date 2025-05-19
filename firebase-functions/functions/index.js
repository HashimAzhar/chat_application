const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document("messages/{messageId}")
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const senderId = message.senderId;
    const text = message.text;

    const users = await admin.firestore().collection("users").get();

    users.forEach(async (user) => {
      if (user.id !== senderId) {
        const token = user.data().fcmToken;
        if (token) {
          await admin.messaging().send({
            token: token,
            notification: {
              title: "New Message",
              body: text,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              senderId: senderId,
            },
          });
        }
      }
    });

    return null;
  });
