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

// PUSH 4: Today is the FIRST day of predicted menstruation (not any day, only day 1)
// Runs once per day at 18:00 UTC
//
// Calendar structure:
//   calendar/{docId}
//     created_by: String  — uid of the user
//     monthCycles: List<Data(monthCycle)>
//       menstruation_days: List<Timestamp> — all days of menstruation [5,6,7,8,9,10]
//       month: Timestamp
//
exports.pushMenstruationDay = functions
  .runWith({ timeoutSeconds: 300, memory: "128MB" })
  .pubsub.schedule("0 18 * * *")
  .onRun(async (_) => {
    const now = new Date();

    // Build today's boundaries in UTC
    const todayStart = new Date(now);
    todayStart.setUTCHours(0, 0, 0, 0);
    const todayEnd = new Date(now);
    todayEnd.setUTCHours(23, 59, 59, 999);

    const calendarSnap = await firestore.collection("calendar").get();

    await Promise.all(
      calendarSnap.docs.map(async (calDoc) => {
        const data = calDoc.data();
        const userId = data.created_by;
        if (!userId) return;

        const monthCycles = data.monthCycles || [];
        let isFirstMenstruationDayToday = false;

        for (const cycle of monthCycles) {
          const menstruationDays = cycle.menstruation_days || [];

          if (menstruationDays.length === 0) continue;
          const firstDay = menstruationDays[0];

          const firstDayDate =
            firstDay && typeof firstDay.toDate === "function"
              ? firstDay.toDate()
              : new Date(firstDay);

          if (firstDayDate >= todayStart && firstDayDate <= todayEnd) {
            isFirstMenstruationDayToday = true;
            break;
          }
        }

        if (!isFirstMenstruationDayToday) return;

        await sendPushToUser(
          `users/${userId}`,
          "По прогнозу сегодня начало месячных ❣️",
          "Отметь, начались ли",
          "CalendarPage",
        );
        console.log(`[pushMenstruationDay] Sent to user: ${userId}`);
      }),
    );

    console.log(
      `[pushMenstruationDay] Done. Processed ${calendarSnap.size} calendar docs`,
    );
  });
