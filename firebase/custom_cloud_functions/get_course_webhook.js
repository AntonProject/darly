const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");
// admin.initializeApp() is handled by FlutterFlow automatically

const db = admin.firestore();
const auth = admin.auth();

const APP_NAME = "Darly";
const SECURITY_TOKEN = "kL9mP4xR7vN2wQ8tY5zH3jB6fG1sD0aC";

// SMTP settings
const smtpTransport = nodemailer.createTransport({
  host: "mail.hosting.reg.ru",
  port: 587,
  secure: false,
  auth: {
    user: "noreply@darly.app",
    pass: "jD1lJ2oO7zlQ6qV3",
  },
  tls: {
    rejectUnauthorized: false,
  },
});

function generatePassword(length = 8) {
  const charset =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let password = "";
  for (let i = 0; i < length; i++) {
    password += charset.charAt(Math.floor(Math.random() * charset.length));
  }
  return password;
}

function setIfNotEmpty(target, field, value) {
  if (value !== null && value !== undefined && String(value).trim() !== "") {
    target[field] = String(value).trim();
  }
}

async function sendEmail(toEmail, appName, password, resetLink) {
  const passwordBlock = password
    ? `<p>Временный пароль: <strong>${password}</strong></p>`
    : "";

  const mailOptions = {
    from: `${appName} <noreply@yourdomain.com>`,
    to: toEmail,
    subject: `Доступ в приложение ${appName}`,
    html: `
      <p>Здравствуйте!</p>
      <p>Для вас создан доступ в приложении <strong>${appName}</strong>.</p>
      <p>Логин (email): <strong>${toEmail}</strong></p>
      ${passwordBlock}
      <p>Вы можете задать свой пароль по ссылке ниже:</p>
      <p><a href="${resetLink}">Создать новый пароль</a></p>
      <p>Если вы сначала войдете по временному паролю, позже его можно будет сменить в приложении.</p>
      <p>С уважением,<br>Команда ${appName}</p>
    `,
  };

  return smtpTransport.sendMail(mailOptions);
}

exports.getCourseWebhook = functions
  .runWith({
    timeoutSeconds: 60,
    memory: "128MB",
  })
  .https.onRequest(async (request, response) => {
    try {
      console.log(
        "[getCourseWebhook] Incoming request method:",
        request.method,
      );

      if (request.method !== "POST") {
        console.log("[getCourseWebhook] Rejected non-POST request");
        return response.status(405).json({ error: "Method not allowed" });
      }

      const token = request.body.token || request.query.token;

      if (!token || token !== SECURITY_TOKEN) {
        console.error("[getCourseWebhook] Invalid token");
        return response.status(403).json({ error: "Forbidden" });
      }

      const email = (request.body.email || "").toLowerCase().trim();
      const educationSubsId =
        request.body.deal_id || request.body.offer_id || null;
      const accessEndDateRaw = request.body.access_end_date || null;

      const firstName = (request.body.first_name || "").trim();
      const lastName = (request.body.last_name || "").trim();
      const fullName = (request.body.name || "").trim();
      const phone = (request.body.phone || "").trim();
      const avatarUrl = (request.body.avatar_url || "").trim();

      console.log("[getCourseWebhook] Payload email:", email);
      console.log(
        "[getCourseWebhook] Payload educationSubsId:",
        educationSubsId,
      );
      console.log(
        "[getCourseWebhook] Payload accessEndDateRaw:",
        accessEndDateRaw,
      );

      if (!email) {
        console.error("[getCourseWebhook] Missing email");
        return response.status(400).json({ error: "Email is required" });
      }

      let expDate = null;
      if (accessEndDateRaw) {
        expDate = admin.firestore.Timestamp.fromDate(
          new Date(accessEndDateRaw),
        );
      } else {
        const oneYearLater = new Date();
        oneYearLater.setFullYear(oneYearLater.getFullYear() + 1);
        expDate = admin.firestore.Timestamp.fromDate(oneYearLater);
      }

      const usersSnapshot = await db
        .collection("users")
        .where("email", "==", email)
        .limit(1)
        .get();

      let userRef;
      let createdAuthUser = false;
      let createdFirestoreUser = false;
      let generatedPassword = null;
      let resetLink = null;
      let emailSent = false;
      let authUid = null;

      if (!usersSnapshot.empty) {
        userRef = usersSnapshot.docs[0].ref;
        const existingUserData = usersSnapshot.docs[0].data() || {};
        authUid = existingUserData.uid || usersSnapshot.docs[0].id;

        console.log("[getCourseWebhook] Firestore user found");
        console.log(
          "[getCourseWebhook] Firestore user doc id:",
          usersSnapshot.docs[0].id,
        );
        console.log("[getCourseWebhook] Firestore user uid:", authUid);
        console.log(
          "[getCourseWebhook] Firestore user email:",
          existingUserData.email,
        );
      } else {
        console.log(
          "[getCourseWebhook] Firestore user not found for email:",
          email,
        );

        generatedPassword = generatePassword(8);

        let userRecord;
        let shouldSendPassword = true;

        try {
          userRecord = await auth.createUser({
            email,
            password: generatedPassword,
          });

          createdAuthUser = true;
          createdFirestoreUser = true;

          console.log("[getCourseWebhook] Firebase Auth user created");
          console.log("[getCourseWebhook] Auth uid:", userRecord.uid);
          console.log("[getCourseWebhook] Auth email:", userRecord.email);
        } catch (authError) {
          if (authError.code === "auth/email-already-exists") {
            userRecord = await auth.getUserByEmail(email);
            shouldSendPassword = false;
            createdFirestoreUser = true;

            console.log("[getCourseWebhook] Firebase Auth user already exists");
            console.log(
              "[getCourseWebhook] Existing auth uid:",
              userRecord.uid,
            );
            console.log(
              "[getCourseWebhook] Existing auth email:",
              userRecord.email,
            );
          } else {
            console.error("[getCourseWebhook] Auth create error:", authError);
            throw authError;
          }
        }

        authUid = userRecord.uid;
        userRef = db.collection("users").doc(authUid);

        resetLink = await auth.generatePasswordResetLink(email);

        const newUserData = {
          email: email,
          uid: authUid,
          created_time: admin.firestore.FieldValue.serverTimestamp(),
          education_subscription_expDate: expDate,
        };

        if (educationSubsId) {
          newUserData.educationSubsId = String(educationSubsId);
        }

        setIfNotEmpty(newUserData, "display_name", fullName || firstName);
        setIfNotEmpty(newUserData, "surname", lastName);
        setIfNotEmpty(newUserData, "phone_number", phone);
        setIfNotEmpty(newUserData, "photo_url", avatarUrl);

        await userRef.set(newUserData, { merge: true });

        console.log(
          "[getCourseWebhook] Firestore user document created/merged",
        );
        console.log("[getCourseWebhook] Firestore user doc id:", authUid);
        console.log("[getCourseWebhook] Firestore user email:", email);

        try {
          await sendEmail(
            email,
            APP_NAME,
            shouldSendPassword ? generatedPassword : "",
            resetLink,
          );
          emailSent = true;
          console.log("[getCourseWebhook] Email sent to:", email);
        } catch (emailError) {
          console.error("[getCourseWebhook] Email send error:", emailError);
        }
      }

      const updateData = {
        education_subscription_expDate: expDate,
      };

      if (educationSubsId) {
        updateData.educationSubsId = String(educationSubsId);
      }

      setIfNotEmpty(updateData, "display_name", fullName || firstName);
      setIfNotEmpty(updateData, "surname", lastName);
      setIfNotEmpty(updateData, "phone_number", phone);
      setIfNotEmpty(updateData, "photo_url", avatarUrl);

      await userRef.set(updateData, { merge: true });

      console.log("[getCourseWebhook] Subscription fields updated");
      console.log("[getCourseWebhook] Final user uid:", authUid);
      console.log("[getCourseWebhook] Final user email:", email);
      console.log("[getCourseWebhook] Final educationSubsId:", educationSubsId);
      console.log(
        "[getCourseWebhook] Final accessEndDateRaw:",
        accessEndDateRaw,
      );

      return response.status(200).json({
        message: "Education subscription activated successfully",
        email: email,
        uid: authUid,
        expDate: accessEndDateRaw,
        educationSubsId: educationSubsId,
        createdAuthUser: createdAuthUser,
        createdFirestoreUser: createdFirestoreUser,
        emailSent: emailSent,
        resetLinkGenerated: !!resetLink,
      });
    } catch (error) {
      console.error("[getCourseWebhook] Error:", error);
      return response.status(500).json({ error: error.message });
    }
  });
