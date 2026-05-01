import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MetaCardsRecord extends FirestoreRecord {
  MetaCardsRecord._(
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

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _text = snapshotData['text'] as String?;
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('metaCards');

  static Stream<MetaCardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MetaCardsRecord.fromSnapshot(s));

  static Future<MetaCardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MetaCardsRecord.fromSnapshot(s));

  static MetaCardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MetaCardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MetaCardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MetaCardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MetaCardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MetaCardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMetaCardsRecordData({
  String? title,
  String? text,
  String? description,
  String? image,
  DateTime? createdAt,
  String? createdBy,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'text': text,
      'description': description,
      'image': image,
      'created_at': createdAt,
      'created_by': createdBy,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class MetaCardsRecordDocumentEquality implements Equality<MetaCardsRecord> {
  const MetaCardsRecordDocumentEquality();

  @override
  bool equals(MetaCardsRecord? e1, MetaCardsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.text == e2?.text &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.index == e2?.index;
  }

  @override
  int hash(MetaCardsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.text,
        e?.description,
        e?.image,
        e?.createdAt,
        e?.createdBy,
        e?.index
      ]);

  @override
  bool isValidKey(Object? o) => o is MetaCardsRecord;
}
