const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.createCalendarForUser = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .firestore.document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userId = context.params.userId;
    const db = admin.firestore();

    try {
      const calendarRef = db.collection("calendar").doc(userId);
      const calendarSnap = await calendarRef.get();

      if (calendarSnap.exists) {
        return null;
      }

      await calendarRef.set({
        monthCycles: [],
        firsDate: null,
        duration: null,
        lengthCycle: null,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
        created_by: userId,
      });

      return null;
    } catch (error) {
      console.error("createCalendarForUser error:", error);
      return null;
    }
  });
