import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationModuleLessonChaptersRecord extends FirestoreRecord {
  EducationModuleLessonChaptersRecord._(
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

  // "task_information" field.
  String? _taskInformation;
  String get taskInformation => _taskInformation ?? '';
  bool hasTaskInformation() => _taskInformation != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "files" field.
  List<String>? _files;
  List<String> get files => _files ?? const [];
  bool hasFiles() => _files != null;

  // "lessonId" field.
  String? _lessonId;
  String get lessonId => _lessonId ?? '';
  bool hasLessonId() => _lessonId != null;

  // "audioId" field.
  String? _audioId;
  String get audioId => _audioId ?? '';
  bool hasAudioId() => _audioId != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _image = snapshotData['image'] as String?;
    _title = snapshotData['title'] as String?;
    _number = castToType<int>(snapshotData['number']);
    _description = snapshotData['description'] as String?;
    _taskInformation = snapshotData['task_information'] as String?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _video = snapshotData['video'] as String?;
    _files = getDataList(snapshotData['files']);
    _lessonId = snapshotData['lessonId'] as String?;
    _audioId = snapshotData['audioId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education_module_lesson_chapters');

  static Stream<EducationModuleLessonChaptersRecord> getDocument(
          DocumentReference ref) =>
      ref
          .snapshots()
          .map((s) => EducationModuleLessonChaptersRecord.fromSnapshot(s));

  static Future<EducationModuleLessonChaptersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref
          .get()
          .then((s) => EducationModuleLessonChaptersRecord.fromSnapshot(s));

  static EducationModuleLessonChaptersRecord fromSnapshot(
          DocumentSnapshot snapshot) =>
      EducationModuleLessonChaptersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationModuleLessonChaptersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationModuleLessonChaptersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationModuleLessonChaptersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationModuleLessonChaptersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationModuleLessonChaptersRecordData({
  DateTime? createdAt,
  String? createdBy,
  String? image,
  String? title,
  int? number,
  String? description,
  String? taskInformation,
  DateTime? startDate,
  String? video,
  String? lessonId,
  String? audioId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'created_by': createdBy,
      'image': image,
      'title': title,
      'number': number,
      'description': description,
      'task_information': taskInformation,
      'startDate': startDate,
      'video': video,
      'lessonId': lessonId,
      'audioId': audioId,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationModuleLessonChaptersRecordDocumentEquality
    implements Equality<EducationModuleLessonChaptersRecord> {
  const EducationModuleLessonChaptersRecordDocumentEquality();

  @override
  bool equals(EducationModuleLessonChaptersRecord? e1,
      EducationModuleLessonChaptersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.image == e2?.image &&
        e1?.title == e2?.title &&
        e1?.number == e2?.number &&
        e1?.description == e2?.description &&
        e1?.taskInformation == e2?.taskInformation &&
        e1?.startDate == e2?.startDate &&
        e1?.video == e2?.video &&
        listEquality.equals(e1?.files, e2?.files) &&
        e1?.lessonId == e2?.lessonId &&
        e1?.audioId == e2?.audioId;
  }

  @override
  int hash(EducationModuleLessonChaptersRecord? e) =>
      const ListEquality().hash([
        e?.createdAt,
        e?.createdBy,
        e?.image,
        e?.title,
        e?.number,
        e?.description,
        e?.taskInformation,
        e?.startDate,
        e?.video,
        e?.files,
        e?.lessonId,
        e?.audioId
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationModuleLessonChaptersRecord;
}
