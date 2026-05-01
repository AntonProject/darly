// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatAssistantMessageStruct extends FFFirebaseStruct {
  ChatAssistantMessageStruct({
    String? chatId,
    String? message,
    String? imagePath,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _chatId = chatId,
        _message = message,
        _imagePath = imagePath,
        super(firestoreUtilData);

  // "chatId" field.
  String? _chatId;
  String get chatId => _chatId ?? '';
  set chatId(String? val) => _chatId = val;

  bool hasChatId() => _chatId != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  set imagePath(String? val) => _imagePath = val;

  bool hasImagePath() => _imagePath != null;

  static ChatAssistantMessageStruct fromMap(Map<String, dynamic> data) =>
      ChatAssistantMessageStruct(
        chatId: data['chatId'] as String?,
        message: data['message'] as String?,
        imagePath: data['imagePath'] as String?,
      );

  static ChatAssistantMessageStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatAssistantMessageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'chatId': _chatId,
        'message': _message,
        'imagePath': _imagePath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'chatId': serializeParam(
          _chatId,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'imagePath': serializeParam(
          _imagePath,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatAssistantMessageStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ChatAssistantMessageStruct(
        chatId: deserializeParam(
          data['chatId'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        imagePath: deserializeParam(
          data['imagePath'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatAssistantMessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatAssistantMessageStruct &&
        chatId == other.chatId &&
        message == other.message &&
        imagePath == other.imagePath;
  }

  @override
  int get hashCode => const ListEquality().hash([chatId, message, imagePath]);
}

ChatAssistantMessageStruct createChatAssistantMessageStruct({
  String? chatId,
  String? message,
  String? imagePath,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatAssistantMessageStruct(
      chatId: chatId,
      message: message,
      imagePath: imagePath,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatAssistantMessageStruct? updateChatAssistantMessageStruct(
  ChatAssistantMessageStruct? chatAssistantMessage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatAssistantMessage
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatAssistantMessageStructData(
  Map<String, dynamic> firestoreData,
  ChatAssistantMessageStruct? chatAssistantMessage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatAssistantMessage == null) {
    return;
  }
  if (chatAssistantMessage.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatAssistantMessage.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatAssistantMessageData =
      getChatAssistantMessageFirestoreData(chatAssistantMessage, forFieldValue);
  final nestedData =
      chatAssistantMessageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      chatAssistantMessage.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatAssistantMessageFirestoreData(
  ChatAssistantMessageStruct? chatAssistantMessage, [
  bool forFieldValue = false,
]) {
  if (chatAssistantMessage == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatAssistantMessage.toMap());

  // Add any Firestore field values
  mapToFirestore(chatAssistantMessage.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatAssistantMessageListFirestoreData(
  List<ChatAssistantMessageStruct>? chatAssistantMessages,
) =>
    chatAssistantMessages
        ?.map((e) => getChatAssistantMessageFirestoreData(e, true))
        .toList() ??
    [];
