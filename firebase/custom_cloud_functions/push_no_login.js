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

exports.pushNoLogin = functions
  .runWith({ timeoutSeconds: 300, memory: "128MB" })
  .pubsub.schedule("0 9 * * *")
  .onRun(async (_) => {
    const THRESHOLD_MS = 7 * 24 * 60 * 60 * 1000; // 7 days
    const cutoff = new Date(Date.now() - THRESHOLD_MS);

    const usersSnap = await firestore
      .collection("users")
      .where("last_login_at", "<=", cutoff)
      .get();

    await Promise.all(
      usersSnap.docs.map(async (doc) => {
        await sendPushToUser(
          `users/${doc.id}`,
          "Мы рядом🤍",
          "Загляни в своё женское пространство💎",
          "HomePage",
        );
        console.log(`[pushNoLogin] Sent to user: ${doc.id}`);
      }),
    );

    console.log(`[pushNoLogin] Done. Notified: ${usersSnap.size} users`);
  });
