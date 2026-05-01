const functions = require("firebase-functions");
const admin = require("firebase-admin");

// To avoid deployment errors, do not call admin.initializeApp() in your code

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "ff_push_notifications";
const firestore = admin.firestore();

exports.createNotificationsForUsers = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "512MB",
  })
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    // Write your code below!
    try {
      const notificationData = snapshot.data();
      const title = notificationData.notification_title || "";
      const text = notificationData.notification_text || "";
      const image = notificationData.notification_image_url || "";
      const targetAudience = notificationData.target_audience || "All";
      const userRefsStr = notificationData.user_refs || "";

      // Skip if title or text is empty
      if (!title || !text) {
        console.log("Skipping notification creation: title or text is empty");
        return;
      }

      // Get list of target users
      let userIds = [];
      let shouldIncludeUserId = false; // Flag to determine if userId should be filled

      if (userRefsStr) {
        // If specific users are targeted, extract their IDs - userId will be filled
        shouldIncludeUserId = true;
        const userRefs = userRefsStr.trim().split(",");
        userIds = userRefs
          .map((ref) => {
            const parts = ref.trim().split("/");
            return parts[parts.length - 1];
          })
          .filter((id) => id && id.length > 0);
      } else {
        // Get all users from the users collection
        if (targetAudience === "All") {
          // For "All" audience, don't include userId (create one notification without userId)
          shouldIncludeUserId = false;
          // Create single notification without userId
          userIds = [null]; // Use null to indicate single notification
        } else {
          // Filter by target audience (device type) using FCM tokens - userId will be filled
          shouldIncludeUserId = true;
          const userTokensQuery =
            firestore.collectionGroup(kFcmTokensCollection);
          const userTokensSnapshot = await userTokensQuery.get();
          const userIdSet = new Set();

          userTokensSnapshot.docs.forEach((tokenDoc) => {
            const tokenData = tokenDoc.data();
            const deviceType = tokenData.device_type || "";
            if (deviceType === targetAudience) {
              // Extract user ID from token document path: users/{userId}/fcm_tokens/{tokenId}
              const tokenPath = tokenDoc.ref.path;
              const pathParts = tokenPath.split("/");
              if (pathParts.length >= 2 && pathParts[0] === "users") {
                userIdSet.add(pathParts[1]);
              }
            }
          });

          userIds = Array.from(userIdSet);
        }
      }

      console.log(
        `Creating notifications for ${shouldIncludeUserId ? userIds.length : 1} ${shouldIncludeUserId ? "users" : "all users"}`,
      );

      // Create notifications in batches (Firestore limit is 500 operations per batch)
      const batchSize = 500;
      let numCreated = 0;

      for (let i = 0; i < userIds.length; i += batchSize) {
        const batch = firestore.batch();
        const userIdsBatch = userIds.slice(
          i,
          Math.min(i + batchSize, userIds.length),
        );

        for (const userId of userIdsBatch) {
          const notificationRef = firestore.collection("notifications").doc();
          const notificationData = {
            title: title,
            text: text,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            readingUsers: [], // Empty list instead of reading bool
            image: image || null,
          };

          // Add userId only if shouldIncludeUserId is true and userId is not null
          if (shouldIncludeUserId && userId) {
            notificationData.created_by = userId;
            notificationData.userId = userId;
          }
          // If userId is null or shouldIncludeUserId is false, userId field is not added

          batch.set(notificationRef, notificationData);
        }

        await batch.commit();
        numCreated += userIdsBatch.length;
        console.log(`Created ${numCreated} notifications`);
      }

      // Update the push notification document with notification creation status
      await snapshot.ref.update({
        notifications_created: true,
        notifications_count: numCreated,
      });

      console.log(`Successfully created ${numCreated} notifications`);
    } catch (e) {
      console.error(`Error creating notifications: ${e}`);
      await snapshot.ref.update({
        notifications_created: false,
        notifications_error: `${e}`,
      });
    }
    // Write your code above!
  });
