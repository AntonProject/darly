const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Do not call admin.initializeApp() here - already initialized in main index.js

const firestore = admin.firestore();
const kNotificationsCollection = "notifications";
const kPushNotificationsCollection = "ff_push_notifications";
const kInitialPageName = "NotificationPage";

function getString(value) {
  return typeof value === "string" ? value.trim() : "";
}

function getUserRef(value) {
  const userId = getString(value);

  if (!userId) {
    return "";
  }

  if (userId.startsWith("users/")) {
    return userId;
  }

  return `users/${userId}`;
}

function hasReadyPayload(notification) {
  return Boolean(getString(notification.title) && getString(notification.text));
}

async function createPushNotification({
  notificationId,
  title,
  text,
  image,
  userRef,
  notificationPath,
}) {
  const pushRef = firestore
    .collection(kPushNotificationsCollection)
    .doc(`notificationPush_${notificationId}`);

  const pushData = {
    notification_title: title,
    notification_text: text,
    notification_sound: "default",
    initial_page_name: kInitialPageName,
    parameter_data: "{}",
    user_refs: userRef,
    target_audience: "All",
    scheduled_time: "",
    status: "started",
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
    source_notification_ref: notificationPath,
    skip_notification_document: true,
  };

  if (image) {
    pushData.notification_image_url = image;
  }

  return firestore.runTransaction(async (transaction) => {
    const existing = await transaction.get(pushRef);
    if (existing.exists) {
      return false;
    }

    transaction.create(pushRef, pushData);
    return true;
  });
}

exports.notificationPush = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .firestore.document(`${kNotificationsCollection}/{notificationId}`)
  .onWrite(async (change, context) => {
    if (!change.after.exists) {
      return null;
    }

    const notification = change.after.data() || {};

    if (notification.source_push_notification_ref) {
      console.log(
        `[notificationPush] Skipped ${change.after.ref.path}: already created from push notification`,
      );
      return null;
    }

    const title = getString(notification.title);
    const text = getString(notification.text);
    const image = getString(notification.image);

    if (!title || !text) {
      console.log(
        `[notificationPush] Skipped ${change.after.ref.path}: title or text is empty`,
      );
      return null;
    }

    const previousNotification = change.before.exists
      ? change.before.data() || {}
      : {};

    if (hasReadyPayload(previousNotification)) {
      console.log(
        `[notificationPush] Skipped ${change.after.ref.path}: push payload was already ready`,
      );
      return null;
    }

    const userRef =
      getUserRef(notification.userId) || getUserRef(notification.created_by);

    const created = await createPushNotification({
      notificationId: context.params.notificationId,
      title,
      text,
      image,
      userRef,
      notificationPath: change.after.ref.path,
    });

    if (!created) {
      console.log(
        `[notificationPush] Skipped ${change.after.ref.path}: push document already exists`,
      );
      return null;
    }

    console.log(
      `[notificationPush] Created push for notifications/${context.params.notificationId}` +
        (userRef ? ` to ${userRef}` : " to all users"),
    );

    return null;
  });
