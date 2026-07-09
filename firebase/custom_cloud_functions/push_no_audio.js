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

exports.pushNoAudio = functions
  .runWith({ timeoutSeconds: 300, memory: "128MB" })
  // Every 3 days at 10:00 UTC, on days 2,5,8,… (staggered vs the other
  // reminders so they never land on the same day).
  .pubsub.schedule("0 10 2-31/3 * *")
  .onRun(async (_) => {
    const THRESHOLD_MS = 7 * 24 * 60 * 60 * 1000; // 7 days
    const cutoff = new Date(Date.now() - THRESHOLD_MS);

    const usersSnap = await firestore
      .collection("users")
      .where("last_listened_at", "<=", cutoff)
      .get();

    // Cooldown: never send this reminder to the same user more than once per
    // 7 days, even though the schedule keeps matching the same inactive users
    const COOLDOWN_MS = 7 * 24 * 60 * 60 * 1000;
    let sent = 0;

    await Promise.all(
      usersSnap.docs.map(async (doc) => {
        const data = doc.data() || {};
        const last = data.last_noaudio_push_at;
        const lastDate =
          last && typeof last.toDate === "function" ? last.toDate() : null;
        if (lastDate && Date.now() - lastDate.getTime() < COOLDOWN_MS) {
          return; // already reminded within the cooldown window
        }

        await sendPushToUser(
          `users/${doc.id}`,
          "Как ты? ❤️",
          "Сделаем короткую практику?",
          "AudioPage",
        );
        await doc.ref.update({
          last_noaudio_push_at: admin.firestore.FieldValue.serverTimestamp(),
        });
        sent += 1;
        console.log(`[pushNoAudio] Sent to user: ${doc.id}`);
      }),
    );

    console.log(
      `[pushNoAudio] Done. Candidates: ${usersSnap.size}, sent: ${sent}`,
    );
  });
