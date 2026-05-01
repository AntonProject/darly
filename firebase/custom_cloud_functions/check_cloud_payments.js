const functions = require("firebase-functions");
const admin = require("firebase-admin");

function parseCloudPaymentsDate(dateStr) {
  if (!dateStr) return null;

  let date = null;

  const match = dateStr.match(/\/Date\((\d+)\)\//);
  if (match) {
    const timestamp = parseInt(match[1]);
    date = new Date(timestamp);
  } else {
    try {
      date = new Date(dateStr);
    } catch (error) {
      console.error("Error parsing date:", dateStr, error);
      return null;
    }
  }

  if (date && !isNaN(date.getTime())) {
    return date;
  }

  console.error("Invalid date parsed:", dateStr);
  return null;
}

exports.checkCloudPayments = functions
  .region("europe-west3")
  .runWith({
    timeoutSeconds: 540,
    memory: "128MB",
  })
  .https.onRequest(async (req, res) => {
    const userId = req.body.AccountId;
    const status = req.body.Status;
    const orderId = req.body.InvoiceId || null;
    const cancelCode = req.body.ReasonCode || false;
    const cancelReason = req.body.Reason || false;
    const isSubscriptionRenewal = !orderId;

    const db = admin.firestore();

    if (isSubscriptionRenewal) {
      console.log(
        "Received subscription renewal with transaction Id:",
        req.body.Id,
        "and status:",
        req.body.Status,
      );

      const userRef = db.collection("users").doc(userId);
      const userDoc = await userRef.get();

      if (userDoc.exists) {
        const userData = userDoc.data();
        const updateData = {};

        if (status === "Cancelled" || status === "cancelled") {
          updateData.subscription_id = admin.firestore.FieldValue.delete();
          updateData.subscription_cancelled = true;
          updateData.subscription_cancelledAt =
            admin.firestore.FieldValue.serverTimestamp();

          console.log(
            "Subscription cancelled - auto-renewal disabled, subscription remains active until expDate",
          );
        } else {
          if (req.body.NextTransactionDate) {
            const nextTransactionDate = new Date(req.body.NextTransactionDate);
            updateData.subscription_nextTransactionDate =
              admin.firestore.Timestamp.fromDate(nextTransactionDate);
            updateData.subscription_expDate =
              admin.firestore.Timestamp.fromDate(nextTransactionDate);
            console.log(
              "Subscription renewal: dates updated to",
              nextTransactionDate,
            );
          } else {
            console.log(
              "Subscription renewal: no NextTransactionDate provided, dates not updated",
            );
          }
        }

        if (Object.keys(updateData).length > 0) {
          await userRef.update(updateData);
          console.log(
            "Subscription renewal updated with the next data:",
            req.body.Status,
            req.body.Id,
          );
        } else {
          console.log("No data to update, skipping user update");
        }

        res.status(200).json({
          code: 0,
          message: "Данные подписки успешно обновлены",
        });
        return;
      } else {
        console.error("Error: User not found in /users collection");
        res.status(200).json({
          message: "Пользователь не найден в коллекции /users",
        });
        return;
      }
    } else {
      console.log(
        "Received initial subscription order with Id:",
        orderId,
        "and status:",
        status,
      );
      console.log("Full request body:", JSON.stringify(req.body, null, 2));

      if (!orderId) {
        console.error("Error: Missing order_id parameter");
        res.status(200).json({
          code: 0,
          message: "Не указан параметр order_id",
        });
      } else {
        let data = {};
        try {
          if (req.body.Data) {
            data =
              typeof req.body.Data === "string"
                ? JSON.parse(req.body.Data)
                : req.body.Data;
          }
        } catch (e) {
          console.error("Error parsing Data field:", e.message);
        }

        const isTrialSubscription = data.isTrialSubscription == "true";
        const trialDays = parseInt(data.trialDays) || 3;
        const recurrentPeriod = parseInt(data.recurrentPeriod) || 1;
        const recurrentInterval = data.recurrentInterval || "Month";

        console.log(
          'Looking for order document in collection "order" with ID:',
          orderId,
        );
        let orderRef = db.collection("order").doc(orderId);

        let orderSnapshot = await orderRef.get();
        let orderData = orderSnapshot.data();

        if (!orderSnapshot.exists) {
          console.warn(
            "Order document not found immediately. Waiting 1 second and retrying...",
          );
          await new Promise((resolve) => setTimeout(resolve, 1000));
          orderSnapshot = await orderRef.get();
          orderData = orderSnapshot.data();
        }

        if (!orderSnapshot.exists) {
          console.error(
            'Error: Order document not found in collection "order" with ID:',
            orderId,
          );
          console.log("Request details:", {
            orderId: orderId,
            status: status,
            userId: userId,
            invoiceId: req.body.InvoiceId,
            transactionId: req.body.TransactionId,
            subscriptionId: req.body.SubscriptionId,
          });

          const collectionsToCheck = [
            "subscriptions",
            "payments",
            "transactions",
          ];
          let foundInCollection = null;

          for (const collectionName of collectionsToCheck) {
            try {
              const altRef = db.collection(collectionName).doc(orderId);
              const altDoc = await altRef.get();
              if (altDoc.exists) {
                console.log(`Found document in "${collectionName}" collection`);
                foundInCollection = collectionName;
                orderSnapshot = altDoc;
                orderData = altDoc.data();
                break;
              }
            } catch (searchError) {
              console.error(
                `Error searching in "${collectionName}":`,
                searchError.message,
              );
            }
          }

          if (!orderSnapshot.exists) {
            res.status(200).json({
              code: 0,
              message: `Документ заказа не найден в коллекции "order" с ID: ${orderId}. Проверьте, что документ был создан перед обработкой платежа.`,
            });
            return;
          } else {
            console.log(
              `Using document from "${foundInCollection}" collection`,
            );
            orderRef = db.collection(foundInCollection).doc(orderId);
          }
        }

        console.log(
          "Order document found. Current status:",
          orderData?.status,
          "Current paid:",
          orderData?.paid,
        );

        const isAlreadySucceeded = orderData.status === "succeeded";
        const shouldUpdateUserOnly =
          isAlreadySucceeded && status === "Completed";

        let needsUserDataUpdate = false;
        let activeSubscriptionData = null;

        if (isAlreadySucceeded && req.body.SubscriptionId) {
          let checkClientId = null;
          if (
            orderData.client_id !== undefined &&
            orderData.client_id !== null
          ) {
            checkClientId = String(orderData.client_id);
          } else if (orderData.rlUser) {
            const rlUserStr = String(orderData.rlUser);
            const parts = rlUserStr.split("/");
            if (parts.length >= 3 && parts[parts.length - 2] === "users") {
              checkClientId = parts[parts.length - 1];
            }
          } else if (userId) {
            checkClientId = String(userId);
          }

          if (checkClientId) {
            const checkUserRef = db.collection("users").doc(checkClientId);
            const checkUserDoc = await checkUserRef.get();
            if (checkUserDoc.exists) {
              const checkUserData = checkUserDoc.data();
              if (!checkUserData.subscription_id) {
                console.log(
                  "Order is succeeded but user data is missing subscription_id, checking CloudPayments API",
                );

                let cloudKey = null;
                let secretKey = null;
                try {
                  const remoteConfig = admin.remoteConfig();
                  const template = await remoteConfig.getTemplate();
                  const cloudKeyParam = template.parameters?.cloudKey;
                  const secretKeyParam = template.parameters?.secretKey;
                  cloudKey =
                    cloudKeyParam?.defaultValue?.value ||
                    (cloudKeyParam?.conditionalValues &&
                      Object.values(cloudKeyParam.conditionalValues)[0]?.value);
                  secretKey =
                    secretKeyParam?.defaultValue?.value ||
                    (secretKeyParam?.conditionalValues &&
                      Object.values(secretKeyParam.conditionalValues)[0]
                        ?.value);
                } catch (error) {
                  console.error(
                    "Error getting Remote Config, trying functions.config():",
                    error,
                  );
                  try {
                    cloudKey = functions.config().cloudpayments?.cloudKey;
                    secretKey = functions.config().cloudpayments?.secretKey;
                  } catch (configError) {
                    console.error(
                      "Error getting functions.config():",
                      configError,
                    );
                  }
                }

                if (!cloudKey) cloudKey = "pk_d07912a5de0f0bbad69bb4889e3be";
                if (!secretKey) secretKey = "ebd5997b306e6a7cd9cc4e140bacaf3e";

                try {
                  const authHeader = `Basic ${Buffer.from(`${cloudKey}:${secretKey}`).toString("base64")}`;
                  const getResponse = await fetch(
                    "https://api.cloudpayments.ru/subscriptions/get",
                    {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json",
                        Authorization: authHeader,
                      },
                      body: JSON.stringify({
                        Id: req.body.SubscriptionId,
                      }),
                    },
                  );

                  const subscriptionData = await getResponse.json();
                  if (
                    subscriptionData.Success &&
                    subscriptionData.Model &&
                    subscriptionData.Model.Status === "Active"
                  ) {
                    activeSubscriptionData = subscriptionData.Model;
                    needsUserDataUpdate = true;
                    console.log(
                      "Found active subscription in CloudPayments, will update user data",
                    );
                  } else {
                    console.log(
                      "Subscription not found or not active in CloudPayments",
                    );
                  }
                } catch (apiError) {
                  console.error(
                    "Error checking subscription in CloudPayments API:",
                    apiError.message,
                  );
                }
              }
            }
          }
        }

        if (
          isAlreadySucceeded &&
          !shouldUpdateUserOnly &&
          !needsUserDataUpdate
        ) {
          console.log(
            'Payment status is already "succeeded" and webhook status is:',
            status,
          );
          console.log(
            'Skipping update because webhook status is not "Completed" and user data is already updated',
          );
          res.status(200).json({
            code: 0,
            message: 'Статус платежа уже "succeeded"',
          });
          return;
        }

        if (
          needsUserDataUpdate &&
          activeSubscriptionData &&
          status !== "Completed"
        ) {
          try {
            let client_id = null;
            if (
              orderData.client_id !== undefined &&
              orderData.client_id !== null
            ) {
              client_id = String(orderData.client_id);
            } else if (orderData.rlUser) {
              const rlUserStr = String(orderData.rlUser);
              const parts = rlUserStr.split("/");
              if (parts.length >= 3 && parts[parts.length - 2] === "users") {
                client_id = parts[parts.length - 1];
              }
            } else if (userId) {
              client_id = String(userId);
            }

            if (client_id) {
              const userRef = db.collection("users").doc(client_id);
              const updateUserData = {
                subscription_id: activeSubscriptionData.Id,
              };

              if (activeSubscriptionData.NextTransactionDate) {
                const nextDate = parseCloudPaymentsDate(
                  activeSubscriptionData.NextTransactionDate,
                );
                if (nextDate) {
                  updateUserData.subscription_nextTransactionDate =
                    admin.firestore.Timestamp.fromDate(nextDate);
                  updateUserData.subscription_expDate =
                    admin.firestore.Timestamp.fromDate(nextDate);
                }
              } else if (activeSubscriptionData.EndDate) {
                const endDate = parseCloudPaymentsDate(
                  activeSubscriptionData.EndDate,
                );
                if (endDate) {
                  updateUserData.subscription_expDate =
                    admin.firestore.Timestamp.fromDate(endDate);
                }
              }

              await userRef.update(updateUserData);
              console.log(
                "User subscription data updated from CloudPayments API",
              );
              res.status(200).json({
                code: 0,
                message: "Данные подписки обновлены из CloudPayments API",
              });
              return;
            }
          } catch (error) {
            console.error(
              "Error updating user data from CloudPayments API:",
              error.message,
            );
          }
        }

        if (status === "Completed" || needsUserDataUpdate) {
          try {
            const orderUpdateData = {
              status: "succeeded",
              paid: true,
              transaction_id: req.body.TransactionId || null,
              payment_id: req.body.Id || null,
            };

            if (req.body.SubscriptionId) {
              orderUpdateData.subscription_id = req.body.SubscriptionId;
            }

            await orderRef.update(orderUpdateData);
            if (isAlreadySucceeded) {
              console.log(
                "Order already succeeded, but updated order fields and user data",
              );
            } else {
              console.log(
                'Initial subscription order status updated to "succeeded"',
              );
            }

            let client_id = null;
            if (
              orderData.client_id !== undefined &&
              orderData.client_id !== null
            ) {
              client_id = String(orderData.client_id);
            } else if (orderData.rlUser) {
              const rlUserStr = String(orderData.rlUser);
              const parts = rlUserStr.split("/");
              if (parts.length >= 3 && parts[parts.length - 2] === "users") {
                client_id = parts[parts.length - 1];
              }
            } else if (userId) {
              client_id = String(userId);
            } else {
              console.error(
                "Error: client_id not found in order data and userId is missing",
              );
              res.status(200).json({
                message: "Не удалось определить ID пользователя",
              });
              return;
            }

            const userRef = db.collection("users").doc(client_id);
            const userDoc = await userRef.get();

            if (!userDoc.exists) {
              console.error(
                "Error: User not found in /users collection with ID:",
                client_id,
              );
              res.status(200).json({
                message: "Пользователь не найден в коллекции /users",
              });
              return;
            }

            const updateUserData = {};

            if (activeSubscriptionData && activeSubscriptionData.Id) {
              updateUserData.subscription_id = activeSubscriptionData.Id;
            } else if (req.body.SubscriptionId) {
              updateUserData.subscription_id = req.body.SubscriptionId;
            }

            if (updateUserData.subscription_id) {
              let orderDate = new Date();
              if (orderData.date) {
                if (
                  orderData.date.toDate &&
                  typeof orderData.date.toDate === "function"
                ) {
                  orderDate = orderData.date.toDate();
                } else if (orderData.date instanceof Date) {
                  orderDate = orderData.date;
                } else if (orderData.date.seconds !== undefined) {
                  orderDate = new admin.firestore.Timestamp(
                    orderData.date.seconds,
                    orderData.date.nanoseconds || 0,
                  ).toDate();
                } else {
                  orderDate = new Date(orderData.date);
                }

                if (isNaN(orderDate.getTime())) {
                  console.warn("Invalid order date, using current date");
                  orderDate = new Date();
                }
              }

              let nextTransactionDate = null;
              let expDate = null;

              if (activeSubscriptionData) {
                if (activeSubscriptionData.NextTransactionDate) {
                  nextTransactionDate = parseCloudPaymentsDate(
                    activeSubscriptionData.NextTransactionDate,
                  );
                }
                if (activeSubscriptionData.EndDate) {
                  expDate = parseCloudPaymentsDate(
                    activeSubscriptionData.EndDate,
                  );
                }
              }

              if (!nextTransactionDate && req.body.NextTransactionDate) {
                nextTransactionDate = new Date(req.body.NextTransactionDate);
              }
              if (!expDate && req.body.EndDate) {
                expDate = new Date(req.body.EndDate);
              }

              if (!nextTransactionDate) {
                if (isTrialSubscription) {
                  nextTransactionDate = new Date(orderDate);
                  nextTransactionDate.setDate(
                    nextTransactionDate.getDate() + trialDays,
                  );
                } else {
                  if (recurrentInterval === "Month") {
                    nextTransactionDate = new Date(orderDate);
                    nextTransactionDate.setMonth(
                      nextTransactionDate.getMonth() + recurrentPeriod,
                    );
                  } else {
                    nextTransactionDate = new Date(orderDate);
                    nextTransactionDate.setMonth(
                      nextTransactionDate.getMonth() + 1,
                    );
                  }
                }
              }

              expDate = expDate || nextTransactionDate;

              updateUserData.subscription_nextTransactionDate =
                admin.firestore.Timestamp.fromDate(nextTransactionDate);
              updateUserData.subscription_expDate =
                admin.firestore.Timestamp.fromDate(expDate);
            }

            if (Object.keys(updateUserData).length > 0) {
              await userRef.update(updateUserData);
              console.log("User subscription data updated successfully");
            } else {
              console.log("No user data to update");
            }

            res.status(200).json({
              code: 0,
              message: "Статус платежа успешно обновлён",
            });
            return;
          } catch (error) {
            console.error("Error updating document:", error.message);
            res.status(200).json({
              message: `Произошла ошибка при обновлении документа: ${error.message}`,
            });
            return;
          }
        } else if (cancelReason) {
          try {
            await orderRef.update({
              status: "cancelled",
              paid: false,
              cancel_date: admin.firestore.Timestamp.now(),
              declineReason: `${cancelCode}. ${cancelReason}`,
            });
            console.log('Order status updated to "cancelled"');
            res.status(200).json({
              message: "Статус платежа успешно отменён и обновлён",
            });
            return;
          } catch (error) {
            console.error("Error updating document:", error.message);
            res.status(200).json({
              message: `Произошла ошибка при обновлении документа: ${error.message}`,
            });
            return;
          }
        }
      }
    }
  });
