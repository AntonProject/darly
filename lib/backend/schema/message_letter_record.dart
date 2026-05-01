import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageLetterRecord extends FirestoreRecord {
  MessageLetterRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _text = snapshotData['text'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _image = snapshotData['image'] as String?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('messageLetter');

  static Stream<MessageLetterRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessageLetterRecord.fromSnapshot(s));

  static Future<MessageLetterRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessageLetterRecord.fromSnapshot(s));

  static MessageLetterRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessageLetterRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessageLetterRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessageLetterRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessageLetterRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessageLetterRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessageLetterRecordData({
  String? title,
  String? text,
  DateTime? createdAt,
  String? createdBy,
  String? image,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'text': text,
      'created_at': createdAt,
      'created_by': createdBy,
      'image': image,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessageLetterRecordDocumentEquality
    implements Equality<MessageLetterRecord> {
  const MessageLetterRecordDocumentEquality();

  @override
  bool equals(MessageLetterRecord? e1, MessageLetterRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.text == e2?.text &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.image == e2?.image &&
        e1?.index == e2?.index;
  }

  @override
  int hash(MessageLetterRecord? e) => const ListEquality().hash(
      [e?.title, e?.text, e?.createdAt, e?.createdBy, e?.image, e?.index]);

  @override
  bool isValidKey(Object? o) => o is MessageLetterRecord;
}
