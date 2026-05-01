const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() here — already initialized in main index.js

const firestore = admin.firestore();
const kUserPushCollection = "ff_user_push_notifications";

async function sendPushToUser(userRef, title, body, initialPageName) {
  await firestore.collection(kUserPushCollection).add({
    notification_title: title,
    notification_text: body,
    notification_sound: "default",
    initial_page_name: initialPageName,
    parameter_data: "{}",
    user_refs: userRef,
    sender: userRef,
    target_audience: "All",
    scheduled_time: "",
    status: "started",
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });
}

exports.pushNoChat = functions
  .runWith({ timeoutSeconds: 300, memory: "128MB" })
  .pubsub.schedule("0 11 * * *")
  .onRun(async (_) => {
    const THRESHOLD_MS = 3 * 24 * 60 * 60 * 1000; // 3 days
    const cutoff = new Date(Date.now() - THRESHOLD_MS);

    const usersSnap = await firestore.collection("users").get();

    await Promise.all(
      usersSnap.docs.map(async (userDoc) => {
        const uid = userDoc.id;

        // Check if user sent any message after the cutoff
        const recentMessageSnap = await firestore
          .collection("chat_messages")
          .where("created_by", "==", uid)
          .where("created_at", ">", cutoff)
          .limit(1)
          .get();

        // User is active — skip
        if (!recentMessageSnap.empty) return;

        // Skip brand new users who have never written anything
        const anyMessageSnap = await firestore
          .collection("chat_messages")
          .where("created_by", "==", uid)
          .limit(1)
          .get();

        if (anyMessageSnap.empty) return;

        // User has history but nothing recent — send push
        await sendPushToUser(
          `users/${uid}`,
          "Поговорим? ❤️",
          "Я рядом, чтобы обсудить важное",
          "ChatPage",
        );
        console.log(`[pushNoChat] Sent to user: ${uid}`);
      }),
    );

    console.log(`[pushNoChat] Done. Processed ${usersSnap.size} users`);
  });
