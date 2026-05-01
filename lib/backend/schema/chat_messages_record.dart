import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessagesRecord extends FirestoreRecord {
  ChatMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "chatRef" field.
  DocumentReference? _chatRef;
  DocumentReference? get chatRef => _chatRef;
  bool hasChatRef() => _chatRef != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "file" field.
  FileDTStruct? _file;
  FileDTStruct get file => _file ?? FileDTStruct();
  bool hasFile() => _file != null;

  // "video" field.
  VideoFileStruct? _video;
  VideoFileStruct get video => _video ?? VideoFileStruct();
  bool hasVideo() => _video != null;

  void _initializeFields() {
    _createdBy = snapshotData['created_by'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _text = snapshotData['text'] as String?;
    _chatRef = snapshotData['chatRef'] as DocumentReference?;
    _image = snapshotData['image'] as String?;
    _role = snapshotData['role'] as String?;
    _file = snapshotData['file'] is FileDTStruct
        ? snapshotData['file']
        : FileDTStruct.maybeFromMap(snapshotData['file']);
    _video = snapshotData['video'] is VideoFileStruct
        ? snapshotData['video']
        : VideoFileStruct.maybeFromMap(snapshotData['video']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_messages');

  static Stream<ChatMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatMessagesRecord.fromSnapshot(s));

  static Future<ChatMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatMessagesRecord.fromSnapshot(s));

  static ChatMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatMessagesRecordData({
  String? createdBy,
  DateTime? createdAt,
  String? text,
  DocumentReference? chatRef,
  String? image,
  String? role,
  FileDTStruct? file,
  VideoFileStruct? video,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_by': createdBy,
      'created_at': createdAt,
      'text': text,
      'chatRef': chatRef,
      'image': image,
      'role': role,
      'file': FileDTStruct().toMap(),
      'video': VideoFileStruct().toMap(),
    }.withoutNulls,
  );

  // Handle nested data for "file" field.
  addFileDTStructData(firestoreData, file, 'file');

  // Handle nested data for "video" field.
  addVideoFileStructData(firestoreData, video, 'video');

  return firestoreData;
}

class ChatMessagesRecordDocumentEquality
    implements Equality<ChatMessagesRecord> {
  const ChatMessagesRecordDocumentEquality();

  @override
  bool equals(ChatMessagesRecord? e1, ChatMessagesRecord? e2) {
    return e1?.createdBy == e2?.createdBy &&
        e1?.createdAt == e2?.createdAt &&
        e1?.text == e2?.text &&
        e1?.chatRef == e2?.chatRef &&
        e1?.image == e2?.image &&
        e1?.role == e2?.role &&
        e1?.file == e2?.file &&
        e1?.video == e2?.video;
  }

  @override
  int hash(ChatMessagesRecord? e) => const ListEquality().hash([
        e?.createdBy,
        e?.createdAt,
        e?.text,
        e?.chatRef,
        e?.image,
        e?.role,
        e?.file,
        e?.video
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatMessagesRecord;
}
