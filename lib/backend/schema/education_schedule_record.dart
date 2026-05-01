import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationScheduleRecord extends FirestoreRecord {
  EducationScheduleRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "educationId" field.
  String? _educationId;
  String get educationId => _educationId ?? '';
  bool hasEducationId() => _educationId != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "event_date" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  bool hasEventDate() => _eventDate != null;

  // "event_title" field.
  String? _eventTitle;
  String get eventTitle => _eventTitle ?? '';
  bool hasEventTitle() => _eventTitle != null;

  void _initializeFields() {
    _educationId = snapshotData['educationId'] as String?;
    _createdBy = snapshotData['created_by'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _eventDate = snapshotData['event_date'] as DateTime?;
    _eventTitle = snapshotData['event_title'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education_schedule');

  static Stream<EducationScheduleRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EducationScheduleRecord.fromSnapshot(s));

  static Future<EducationScheduleRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EducationScheduleRecord.fromSnapshot(s));

  static EducationScheduleRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationScheduleRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationScheduleRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationScheduleRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationScheduleRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationScheduleRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationScheduleRecordData({
  String? educationId,
  String? createdBy,
  DateTime? createdAt,
  DateTime? eventDate,
  String? eventTitle,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'educationId': educationId,
      'created_by': createdBy,
      'created_at': createdAt,
      'event_date': eventDate,
      'event_title': eventTitle,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationScheduleRecordDocumentEquality
    implements Equality<EducationScheduleRecord> {
  const EducationScheduleRecordDocumentEquality();

  @override
  bool equals(EducationScheduleRecord? e1, EducationScheduleRecord? e2) {
    return e1?.educationId == e2?.educationId &&
        e1?.createdBy == e2?.createdBy &&
        e1?.createdAt == e2?.createdAt &&
        e1?.eventDate == e2?.eventDate &&
        e1?.eventTitle == e2?.eventTitle;
  }

  @override
  int hash(EducationScheduleRecord? e) => const ListEquality().hash([
        e?.educationId,
        e?.createdBy,
        e?.createdAt,
        e?.eventDate,
        e?.eventTitle
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationScheduleRecord;
}
