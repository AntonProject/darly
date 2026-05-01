import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationModulesRecord extends FirestoreRecord {
  EducationModulesRecord._(
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

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  bool hasNumber() => _number != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "task_information" field.
  String? _taskInformation;
  String get taskInformation => _taskInformation ?? '';
  bool hasTaskInformation() => _taskInformation != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "educationId" field.
  String? _educationId;
  String get educationId => _educationId ?? '';
  bool hasEducationId() => _educationId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _image = snapshotData['image'] as String?;
    _title = snapshotData['title'] as String?;
    _number = castToType<int>(snapshotData['number']);
    _description = snapshotData['description'] as String?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _taskInformation = snapshotData['task_information'] as String?;
    _video = snapshotData['video'] as String?;
    _educationId = snapshotData['educationId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education_modules');

  static Stream<EducationModulesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EducationModulesRecord.fromSnapshot(s));

  static Future<EducationModulesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EducationModulesRecord.fromSnapshot(s));

  static EducationModulesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationModulesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationModulesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationModulesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationModulesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationModulesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationModulesRecordData({
  DateTime? createdAt,
  String? createdBy,
  String? image,
  String? title,
  int? number,
  String? description,
  DateTime? startDate,
  String? taskInformation,
  String? video,
  String? educationId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'created_by': createdBy,
      'image': image,
      'title': title,
      'number': number,
      'description': description,
      'startDate': startDate,
      'task_information': taskInformation,
      'video': video,
      'educationId': educationId,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationModulesRecordDocumentEquality
    implements Equality<EducationModulesRecord> {
  const EducationModulesRecordDocumentEquality();

  @override
  bool equals(EducationModulesRecord? e1, EducationModulesRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.image == e2?.image &&
        e1?.title == e2?.title &&
        e1?.number == e2?.number &&
        e1?.description == e2?.description &&
        e1?.startDate == e2?.startDate &&
        e1?.taskInformation == e2?.taskInformation &&
        e1?.video == e2?.video &&
        e1?.educationId == e2?.educationId;
  }

  @override
  int hash(EducationModulesRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.createdBy,
        e?.image,
        e?.title,
        e?.number,
        e?.description,
        e?.startDate,
        e?.taskInformation,
        e?.video,
        e?.educationId
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationModulesRecord;
}
