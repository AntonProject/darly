const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.setVideosHideDefault = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .firestore.document("videos/{videoId}")
  .onCreate(async (snap, context) => {
    const data = snap.data() || {};

    if (data.hide === null || data.hide === undefined) {
      try {
        await snap.ref.update({
          hide: false,
        });
      } catch (error) {
        console.error("setVideosHideDefault error:", error);
      }
    }

    return null;
  });
