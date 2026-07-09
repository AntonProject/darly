const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() here — already initialized in main index.js

const kNotificationsCollection = "notifications";
const kWelcomeTitle = "Добро пожаловать в пространство DARLY 💎";
const kWelcomeText =
  "Рада видеть тебя в новой версии приложения! Твой путь — следовать сердцу. Счастливого пути по DARLY ❤️‍🔥";

exports.createWelcomeNotificationForUser = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .firestore.document("users/{userId}")
  .onCreate(async (_, context) => {
    const userId = context.params.userId;
    const firestore = admin.firestore();
    const notificationRef = firestore
      .collection(kNotificationsCollection)
      .doc(`welcome_${userId}`);

    try {
      const notificationSnap = await notificationRef.get();
      if (notificationSnap.exists) {
        console.log(
          `[createWelcomeNotificationForUser] Skipped existing notification for user: ${userId}`,
        );
        return null;
      }

      await notificationRef.set({
        title: kWelcomeTitle,
        text: kWelcomeText,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
        userId,
        readingUsers: [],
      });

      console.log(
        `[createWelcomeNotificationForUser] Created welcome notification for user: ${userId}`,
      );
      return null;
    } catch (error) {
      console.error("createWelcomeNotificationForUser error:", error);
      return null;
    }
  });
