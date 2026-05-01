import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationModuleNotesRecord extends FirestoreRecord {
  EducationModuleNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "lessonId" field.
  String? _lessonId;
  String get lessonId => _lessonId ?? '';
  bool hasLessonId() => _lessonId != null;

  // "educationId" field.
  String? _educationId;
  String get educationId => _educationId ?? '';
  bool hasEducationId() => _educationId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _text = snapshotData['text'] as String?;
    _lessonId = snapshotData['lessonId'] as String?;
    _educationId = snapshotData['educationId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education_module_notes');

  static Stream<EducationModuleNotesRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => EducationModuleNotesRecord.fromSnapshot(s));

  static Future<EducationModuleNotesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EducationModuleNotesRecord.fromSnapshot(s));

  static EducationModuleNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationModuleNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationModuleNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationModuleNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationModuleNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationModuleNotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationModuleNotesRecordData({
  DateTime? createdAt,
  String? createdBy,
  String? text,
  String? lessonId,
  String? educationId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'created_by': createdBy,
      'text': text,
      'lessonId': lessonId,
      'educationId': educationId,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationModuleNotesRecordDocumentEquality
    implements Equality<EducationModuleNotesRecord> {
  const EducationModuleNotesRecordDocumentEquality();

  @override
  bool equals(EducationModuleNotesRecord? e1, EducationModuleNotesRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.text == e2?.text &&
        e1?.lessonId == e2?.lessonId &&
        e1?.educationId == e2?.educationId;
  }

  @override
  int hash(EducationModuleNotesRecord? e) => const ListEquality()
      .hash([e?.createdAt, e?.createdBy, e?.text, e?.lessonId, e?.educationId]);

  @override
  bool isValidKey(Object? o) => o is EducationModuleNotesRecord;
}
