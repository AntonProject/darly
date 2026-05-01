const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.chatMessageStream = functions
  .runWith({
    timeoutSeconds: 540,
    memory: "256MB",
    serviceAccount:
      "firebase-adminsdk-fbsvc@woman-f4872.iam.gserviceaccount.com",
  })
  .https.onCall(async (data, context) => {
    const dialogId = data.chatId;
    const message = data.message;
    const chatRefId = data.chatRefId;
    const userId = data.userId;

    functions.logger.info("chatMessageStream called", {
      authUid: context.auth?.uid || null,
      appCheckAppId: context.app?.appId || null,
      dialogId,
      chatRefId,
      userId,
      messageLength: typeof message === "string" ? message.length : null,
      messagePreview:
        typeof message === "string" ? message.slice(0, 120) : null,
    });

    if (!dialogId || !message || !chatRefId) {
      functions.logger.error("Invalid arguments", {
        dialogId,
        chatRefId,
        hasMessage: !!message,
        logType: "invalid_arguments",
      });

      throw new functions.https.HttpsError(
        "invalid-argument",
        "chatId(dialogId), message, chatRefId are required.",
      );
    }

    const db = admin.firestore();
    const FieldValue = admin.firestore.FieldValue;
    const chatRef = db.collection("chats").doc(chatRefId);

    let chatMessageRef = null;
    let messageDocId = null;

    const fallbackErrorText =
      "Извини, я сейчас не смогла ответить. Попробуй отправить сообщение еще раз чуть позже.";

    let fullText = "";
    let lastFlushAt = Date.now();
    let bufferSinceFlush = "";
    let rawBuffer = "";
    let streamMode = "unknown";
    let eventCount = 0;
    let chunkCount = 0;

    const ensureMessageDocCreated = async () => {
      if (chatMessageRef) return;

      chatMessageRef = db.collection("chat_messages").doc();
      messageDocId = chatMessageRef.id;

      await chatMessageRef.set({
        chatRef,
        created_at: FieldValue.serverTimestamp(),
        createdBy: userId || null,
        role: "assistant",
        text: "",
        status: "streaming",
        externalDialogId: dialogId,
      });

      functions.logger.info("Assistant message doc created", {
        messageDocId,
        chatRefPath: chatRef.path,
      });
    };

    const flushToFirestore = async (force = false) => {
      if (!chatMessageRef) return;

      const now = Date.now();

      if (!force) {
        const tooSoon = now - lastFlushAt < 400;
        const tooSmall = bufferSinceFlush.length < 40;
        if (tooSoon && tooSmall) return;
      }

      await chatMessageRef.update({
        text: fullText,
        updated_at: FieldValue.serverTimestamp(),
      });

      functions.logger.info("Firestore message updated", {
        messageDocId,
        force,
        totalLength: fullText.length,
        flushedChars: bufferSinceFlush.length,
        streamMode,
      });

      lastFlushAt = now;
      bufferSinceFlush = "";
    };

    const writeErrorMessage = async (errorText, rawError) => {
      if (!chatMessageRef) {
        chatMessageRef = db.collection("chat_messages").doc();
        messageDocId = chatMessageRef.id;

        await chatMessageRef.set({
          chatRef,
          created_at: FieldValue.serverTimestamp(),
          createdBy: userId || null,
          role: "assistant",
          text: errorText || fallbackErrorText,
          status: "error",
          errorMessage: rawError || null,
          externalDialogId: dialogId,
          updated_at: FieldValue.serverTimestamp(),
        });

        functions.logger.error("Assistant error message doc created", {
          messageDocId,
          rawError,
          logType: "write_error_message_create",
        });

        return;
      }

      functions.logger.error("Writing error message to Firestore", {
        messageDocId,
        errorText,
        rawError,
        logType: "write_error_message_update",
      });

      await chatMessageRef.update({
        text: errorText || fallbackErrorText,
        status: "error",
        errorMessage: rawError || null,
        updated_at: FieldValue.serverTimestamp(),
      });
    };

    const appendText = async (textPart, source = "plain") => {
      if (!textPart) return;

      await ensureMessageDocCreated();

      if (streamMode === "unknown") {
        streamMode = source;
        functions.logger.info("Detected stream mode", {
          streamMode,
          messageDocId,
        });
      }

      fullText += textPart;
      bufferSinceFlush += textPart;

      functions.logger.info("Text chunk appended", {
        source,
        messageDocId,
        chunkLength: textPart.length,
        totalLength: fullText.length,
        preview: textPart.slice(0, 120),
      });

      await flushToFirestore(false);
    };

    const processSSEBuffer = async () => {
      while (true) {
        const separatorIndex = rawBuffer.indexOf("\n\n");
        if (separatorIndex === -1) break;

        const rawEvent = rawBuffer.slice(0, separatorIndex);
        rawBuffer = rawBuffer.slice(separatorIndex + 2);

        const trimmedEvent = rawEvent.trim();
        if (!trimmedEvent) continue;

        eventCount += 1;

        functions.logger.info("SSE event received", {
          messageDocId,
          eventCount,
          rawEventPreview: trimmedEvent.slice(0, 300),
        });

        const lines = trimmedEvent.split("\n");
        const dataLines = lines
          .filter((line) => line.startsWith("data:"))
          .map((line) => line.slice(5).trim());

        if (!dataLines.length) {
          functions.logger.info("SSE event has no data lines", {
            messageDocId,
            rawEventPreview: trimmedEvent.slice(0, 200),
          });
          continue;
        }

        const dataText = dataLines.join("\n");

        if (dataText === "[DONE]") {
          functions.logger.info("SSE done marker received", {
            messageDocId,
          });
          continue;
        }

        let appended = false;

        try {
          const parsed = JSON.parse(dataText);

          const possibleText =
            parsed?.text ??
            parsed?.message ??
            parsed?.content ??
            parsed?.delta?.content ??
            parsed?.choices?.[0]?.delta?.content ??
            parsed?.choices?.[0]?.message?.content ??
            null;

          if (typeof possibleText === "string" && possibleText.length > 0) {
            appended = true;
            await appendText(possibleText, "sse-json");
          } else {
            functions.logger.info("SSE JSON parsed but no text field found", {
              messageDocId,
              parsed,
            });
          }
        } catch (e) {
          functions.logger.info("SSE data is not JSON, using raw data text", {
            messageDocId,
            dataPreview: dataText.slice(0, 200),
          });
        }

        if (!appended) {
          await appendText(dataText, "sse-text");
        }
      }
    };

    try {
      const requestBody = {
        dialog_id: dialogId,
        message: message,
      };

      functions.logger.info("Sending upstream request", {
        requestBody,
      });

      const response = await fetch("https://pforest-ai.ru:8032/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "text/event-stream, text/plain, application/json, */*",
        },
        body: JSON.stringify(requestBody),
      });

      const responseHeaders = {};
      response.headers.forEach((value, key) => {
        responseHeaders[key] = value;
      });

      const contentType = response.headers.get("content-type") || "";
      const looksLikeSSE = contentType.includes("text/event-stream");

      functions.logger.info("Upstream response received", {
        status: response.status,
        ok: response.ok,
        contentType,
        headers: responseHeaders,
      });

      if (!response.ok) {
        const errorText = await response.text();

        functions.logger.error("Upstream non-OK response", {
          status: response.status,
          bodyPreview: (errorText || "").slice(0, 500),
          logType: "upstream_non_ok",
        });

        await writeErrorMessage(
          fallbackErrorText,
          errorText || `HTTP ${response.status}`,
        );

        return {
          success: false,
          messageId: messageDocId,
          error: errorText || `HTTP ${response.status}`,
          streamMode,
        };
      }

      if (!response.body) {
        functions.logger.error("Response body is empty", {
          logType: "empty_response_body",
        });

        await writeErrorMessage(fallbackErrorText, "Response body is empty.");

        return {
          success: false,
          messageId: messageDocId,
          error: "Response body is empty.",
          streamMode,
        };
      }

      functions.logger.info("Stream parser mode hint", {
        looksLikeSSE,
        contentType,
      });

      const reader = response.body.getReader();
      const decoder = new TextDecoder("utf-8");

      while (true) {
        const { value, done } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value, { stream: true });
        chunkCount += 1;

        functions.logger.info("Raw stream chunk received", {
          chunkCount,
          chunkLength: chunk.length,
          chunkPreview: chunk.slice(0, 300),
        });

        if (!chunk) continue;

        if (looksLikeSSE) {
          if (streamMode === "unknown") {
            streamMode = "sse";
          }

          rawBuffer += chunk;
          await processSSEBuffer();
        } else {
          if (streamMode === "unknown") {
            streamMode = "plain";
            functions.logger.info("Treating stream as plain text");
          }

          await appendText(chunk, "plain");
        }
      }

      const rest = decoder.decode();
      if (rest) {
        functions.logger.info("Decoder tail received", {
          tailLength: rest.length,
          tailPreview: rest.slice(0, 300),
        });

        if (looksLikeSSE) {
          rawBuffer += rest;
        } else {
          await appendText(rest, "plain-tail");
        }
      }

      if (looksLikeSSE && rawBuffer.trim().length > 0) {
        functions.logger.info("Processing final raw buffer", {
          rawBufferPreview: rawBuffer.slice(0, 500),
        });

        await processSSEBuffer();

        const leftover = rawBuffer.trim();
        if (leftover.length > 0) {
          functions.logger.info("Leftover SSE buffer after parsing", {
            leftoverPreview: leftover.slice(0, 300),
          });

          await appendText(leftover, "sse-leftover");
          rawBuffer = "";
        }
      }

      if (!fullText.trim()) {
        functions.logger.error(
          "Upstream stream finished but produced empty text",
          {
            streamMode,
            eventCount,
            chunkCount,
            logType: "empty_upstream_text",
          },
        );

        await writeErrorMessage(
          fallbackErrorText,
          "Empty response from upstream API.",
        );

        return {
          success: false,
          messageId: messageDocId,
          error: "Empty response from upstream API.",
          streamMode,
        };
      }

      await flushToFirestore(true);

      if (chatMessageRef) {
        await chatMessageRef.update({
          text: fullText,
          status: "done",
          updated_at: FieldValue.serverTimestamp(),
        });
      }

      functions.logger.info("Stream completed successfully", {
        messageDocId,
        streamMode,
        eventCount,
        chunkCount,
        finalLength: fullText.length,
        finalPreview: fullText.slice(0, 500),
      });

      return {
        success: true,
        messageId: messageDocId,
        text: fullText,
        streamMode,
        chunkCount,
        eventCount,
      };
    } catch (error) {
      functions.logger.error("Streaming function crashed", {
        messageDocId,
        errorMessage: error?.message || String(error),
        stack: error?.stack || null,
        streamMode,
        chunkCount,
        eventCount,
        partialTextPreview: fullText.slice(0, 500),
        logType: "stream_crash",
      });

      await writeErrorMessage(
        fallbackErrorText,
        error?.message || String(error),
      );

      return {
        success: false,
        messageId: messageDocId,
        error: error?.message || String(error),
        streamMode,
        chunkCount,
        eventCount,
      };
    }
  });
