const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Function to parse CloudPayments date format
function parseCloudPaymentsDate(dateStr) {
  if (!dateStr) return null;

  let date = null;

  // Check format /Date(timestamp)/
  const match = dateStr.match(/\/Date\((\d+)\)\//);
  if (match) {
    const timestamp = parseInt(match[1]);
    date = new Date(timestamp);
  } else {
    // Try standard date parsing
    try {
      date = new Date(dateStr);
    } catch (error) {
      console.error("Error parsing date:", dateStr, error);
      return null;
    }
  }

  // Validate that date is valid
  if (date && !isNaN(date.getTime())) {
    return date;
  }

  console.error("Invalid date parsed:", dateStr);
  return null;
}

exports.restorePurchase = functions
  .region("europe-west6")
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .https.onCall(async (data, context) => {
    // Check authentication
    if (!context.auth || !context.auth.uid) {
      console.error("Unauthorized function call - no auth context");
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated",
      );
    }

    const userId = data.userId;
    const subsId = data.subsId;

    // Write your code below!
    console.log(
      "restorePurchase called for userId:",
      userId,
      "subsId:",
      subsId || "not provided",
      "auth.uid:",
      context.auth.uid,
    );

    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required",
      );
    }

    // Security check: ensure user can only restore their own purchase
    if (userId !== context.auth.uid) {
      console.error(
        "Unauthorized: userId mismatch. userId:",
        userId,
        "auth.uid:",
        context.auth.uid,
      );
      throw new functions.https.HttpsError(
        "permission-denied",
        "User can only restore their own purchase",
      );
    }

    const db = admin.firestore();
    let subscriptionId = subsId;
    let userEmail = null;

    // Get user data
    const userRef = db.collection("users").doc(userId);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      console.error("User not found:", userId);
      return false;
    }

    const userData = userDoc.data();

    // If subscription ID not provided, try to find it
    if (!subscriptionId) {
      // First, check if user has subscription_id
      if (userData.subscription_id) {
        subscriptionId = userData.subscription_id;
        console.log("Found subscription_id in user data:", subscriptionId);
      } else {
        // Get user email to search in CloudPayments
        userEmail = userData.email;
        if (!userEmail) {
          console.error("User email not found for userId:", userId);
          return false;
        }
      }
    }

    // Get CloudPayments API credentials from Remote Config
    // We need both production and test keys to try both modes
    let cloudKey = null;
    let cloudTestKey = null;
    let secretKey = null;
    let secretTestKey = null;

    try {
      const remoteConfig = admin.remoteConfig();
      const template = await remoteConfig.getTemplate();

      // Get values from Remote Config with correct capitalization (cloudKey, cloudTestKey, secretKey, secretTestKey)
      const cloudKeyParam = template.parameters?.cloudKey;
      const cloudTestKeyParam = template.parameters?.cloudTestKey;
      const secretKeyParam = template.parameters?.secretKey;
      const secretTestKeyParam = template.parameters?.secretTestKey;

      // Extract values from parameters (check defaultValue first, then conditionalValues)
      cloudKey =
        cloudKeyParam?.defaultValue?.value ||
        (cloudKeyParam?.conditionalValues &&
          Object.values(cloudKeyParam.conditionalValues)[0]?.value);
      cloudTestKey =
        cloudTestKeyParam?.defaultValue?.value ||
        (cloudTestKeyParam?.conditionalValues &&
          Object.values(cloudTestKeyParam.conditionalValues)[0]?.value);
      secretKey =
        secretKeyParam?.defaultValue?.value ||
        (secretKeyParam?.conditionalValues &&
          Object.values(secretKeyParam.conditionalValues)[0]?.value);
      secretTestKey =
        secretTestKeyParam?.defaultValue?.value ||
        (secretTestKeyParam?.conditionalValues &&
          Object.values(secretTestKeyParam.conditionalValues)[0]?.value);
    } catch (error) {
      console.error(
        "Error getting Remote Config, trying functions.config():",
        error,
      );
      // Fallback to functions.config() with correct capitalization
      try {
        cloudKey = functions.config().cloudpayments?.cloudKey;
        cloudTestKey = functions.config().cloudpayments?.cloudTestKey;
        secretKey = functions.config().cloudpayments?.secretKey;
        secretTestKey = functions.config().cloudpayments?.secretTestKey;
      } catch (configError) {
        console.error("Error getting functions.config():", configError);
      }
    }

    // Final fallback to default values if not found
    if (!cloudKey) {
      cloudKey = "pk_d07912a5de0f0bbad69bb4889e3be";
    }
    if (!cloudTestKey) {
      cloudTestKey = "pk_2d96b405326213cfce461c8ff4ffa";
    }
    if (!secretKey) {
      secretKey = "ebd5997b306e6a7cd9cc4e140bacaf3e";
    }
    if (!secretTestKey) {
      secretTestKey = "633f140e447b2b191a557264ca151c73";
    }

    // Helper function to create auth header
    const createAuthHeader = (publicId, apiSecret) => {
      return `Basic ${Buffer.from(`${publicId}:${apiSecret}`).toString("base64")}`;
    };

    // Helper function to get subscription from CloudPayments
    const getSubscriptionFromCloudPayments = async (
      publicId,
      apiSecret,
      subId,
    ) => {
      const authHeader = createAuthHeader(publicId, apiSecret);
      const getResponse = await fetch(
        "https://api.cloudpayments.ru/subscriptions/get",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: authHeader,
          },
          body: JSON.stringify({
            Id: subId,
          }),
        },
      );
      return await getResponse.json();
    };

    // If we need to search by email, try both production and test modes
    if (!subscriptionId && userEmail) {
      // Try production mode first
      let found = false;
      const modes = [
        { publicId: cloudKey, secret: secretKey, name: "production" },
        { publicId: cloudTestKey, secret: secretTestKey, name: "test" },
      ];

      for (const mode of modes) {
        try {
          const authHeader = createAuthHeader(mode.publicId, mode.secret);
          const findResponse = await fetch(
            "https://api.cloudpayments.ru/subscriptions/find",
            {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
                Authorization: authHeader,
              },
              body: JSON.stringify({
                accountId: userEmail,
              }),
            },
          );

          const findData = await findResponse.json();

          if (findData.Success && findData.Model && findData.Model.length > 0) {
            // Get the first active subscription or the most recent one
            const activeSubscription =
              findData.Model.find((sub) => sub.Status === "Active") ||
              findData.Model[0];
            subscriptionId = activeSubscription.Id;
            console.log(
              `Found subscription_id from CloudPayments (${mode.name} mode):`,
              subscriptionId,
            );
            found = true;
            break;
          }
        } catch (error) {
          console.error(
            `Error searching subscriptions in CloudPayments (${mode.name} mode):`,
            error,
          );
        }
      }

      if (!found) {
        console.error(
          "No subscriptions found in CloudPayments for email:",
          userEmail,
        );
        return false;
      }
    }

    // If still no subscription ID, return false
    if (!subscriptionId) {
      console.error("Subscription ID not found");
      return false;
    }

    // Get subscription details from CloudPayments - try both production and test modes
    let subscriptionData = null;
    let subscription = null;
    const modes = [
      { publicId: cloudKey, secret: secretKey, name: "production" },
      { publicId: cloudTestKey, secret: secretTestKey, name: "test" },
    ];

    for (const mode of modes) {
      try {
        subscriptionData = await getSubscriptionFromCloudPayments(
          mode.publicId,
          mode.secret,
          subscriptionId,
        );

        if (subscriptionData.Success && subscriptionData.Model) {
          subscription = subscriptionData.Model;
          console.log(
            `Found subscription in CloudPayments (${mode.name} mode):`,
            {
              subscriptionId: subscriptionId,
              status: subscription.Status,
              endDate: subscription.EndDate,
              nextTransactionDate: subscription.NextTransactionDate,
              amount: subscription.Amount,
            },
          );
          break;
        }
      } catch (error) {
        console.error(
          `Error getting subscription from CloudPayments (${mode.name} mode):`,
          error,
        );
      }
    }

    if (!subscription) {
      console.error(
        "Failed to get subscription from CloudPayments. Subscription ID:",
        subscriptionId,
      );
      return false;
    }

    // Only update if subscription exists and has valid data
    // No default dates will be written if subscription is not found or invalid

    // Parse dates from CloudPayments (only if subscription was found)
    // Log original dates from CloudPayments
    console.log("Dates from CloudPayments:", {
      EndDate: subscription.EndDate,
      NextTransactionDate: subscription.NextTransactionDate,
      CancelledDate: subscription.CancelledDate,
    });

    const endDate = parseCloudPaymentsDate(
      subscription.EndDate || subscription.NextTransactionDate,
    );
    const nextTransactionDate = parseCloudPaymentsDate(
      subscription.NextTransactionDate,
    );
    const cancelledDate = parseCloudPaymentsDate(subscription.CancelledDate);

    // Log parsed dates
    console.log("Parsed dates:", {
      endDate: endDate ? endDate.toISOString() : null,
      nextTransactionDate: nextTransactionDate
        ? nextTransactionDate.toISOString()
        : null,
      cancelledDate: cancelledDate ? cancelledDate.toISOString() : null,
    });

    // Prepare update data - only subscription_id is always set if subscription exists
    const updateData = {
      subscription_id: subscriptionId,
    };

    // Set subscription expiration date only if valid date was parsed from CloudPayments
    // No default dates - if date is missing or invalid, field is not updated
    if (endDate && endDate instanceof Date && !isNaN(endDate.getTime())) {
      updateData.subscription_expDate =
        admin.firestore.Timestamp.fromDate(endDate);
    }

    // Set next transaction date only if valid date was parsed from CloudPayments
    // No default dates - if date is missing or invalid, field is not updated
    if (
      nextTransactionDate &&
      nextTransactionDate instanceof Date &&
      !isNaN(nextTransactionDate.getTime())
    ) {
      updateData.subscription_nextTransactionDate =
        admin.firestore.Timestamp.fromDate(nextTransactionDate);
    }

    // Note: subscription_cancelDate field is not shown in user schema,
    // but we can set it if needed in the future
    // if (subscription.Status === 'Cancelled' && cancelledDate) {
    //   updateData.subscription_cancelDate = admin.firestore.Timestamp.fromDate(cancelledDate);
    // }

    // Update user document
    await userRef.update(updateData);

    // Format dates for logging - use UTC to avoid timezone issues
    const logData = {
      userId: userId,
      subscriptionId: subscriptionId,
      updatedFields: {
        subscription_id: updateData.subscription_id,
      },
    };

    // Helper function to format date in DD.MM.YYYY using UTC
    const formatDateUTC = (timestamp) => {
      const date = timestamp.toDate();
      // Use UTC methods to avoid timezone conversion issues
      const day = date.getUTCDate();
      const month = date.getUTCMonth() + 1;
      const year = date.getUTCFullYear();
      return `${day}.${month}.${year}`;
    };

    if (updateData.subscription_expDate) {
      logData.updatedFields.subscription_expDate = formatDateUTC(
        updateData.subscription_expDate,
      );
      // Also log the original parsed date for reference
      logData.updatedFields.subscription_expDate_original = endDate
        ? endDate.toISOString()
        : "N/A";
    } else {
      logData.updatedFields.subscription_expDate =
        "not set (not provided by CloudPayments)";
    }

    if (updateData.subscription_nextTransactionDate) {
      logData.updatedFields.subscription_nextTransactionDate = formatDateUTC(
        updateData.subscription_nextTransactionDate,
      );
      // Also log the original parsed date for reference
      logData.updatedFields.subscription_nextTransactionDate_original =
        nextTransactionDate ? nextTransactionDate.toISOString() : "N/A";
    } else {
      logData.updatedFields.subscription_nextTransactionDate =
        "not set (not provided by CloudPayments)";
    }

    console.log("Subscription restored successfully:", logData);

    return true;
    // Write your code above!
  });
