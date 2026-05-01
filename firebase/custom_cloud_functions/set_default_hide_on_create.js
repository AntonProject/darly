const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.setDefaultHideOnCreate = functions.firestore
  .document("{collection}/{docId}")
  .onCreate(async (snap, context) => {
    const collection = context.params.collection;

    if (collection !== "audio" && collection !== "videos") {
      return null;
    }

    const data = snap.data();

    if (data.hide === undefined || data.hide === null) {
      return snap.ref.update({
        hide: false,
      });
    }

    return null;
  });
