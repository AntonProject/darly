import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationReviewsRecord extends FirestoreRecord {
  EducationReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "reviewBefore" field.
  String? _reviewBefore;
  String get reviewBefore => _reviewBefore ?? '';
  bool hasReviewBefore() => _reviewBefore != null;

  // "reviewAfter" field.
  String? _reviewAfter;
  String get reviewAfter => _reviewAfter ?? '';
  bool hasReviewAfter() => _reviewAfter != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "userPhoto" field.
  String? _userPhoto;
  String get userPhoto => _userPhoto ?? '';
  bool hasUserPhoto() => _userPhoto != null;

  // "educationId" field.
  String? _educationId;
  String get educationId => _educationId ?? '';
  bool hasEducationId() => _educationId != null;

  // "userPhotoAfter" field.
  String? _userPhotoAfter;
  String get userPhotoAfter => _userPhotoAfter ?? '';
  bool hasUserPhotoAfter() => _userPhotoAfter != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _reviewBefore = snapshotData['reviewBefore'] as String?;
    _reviewAfter = snapshotData['reviewAfter'] as String?;
    _userName = snapshotData['userName'] as String?;
    _userPhoto = snapshotData['userPhoto'] as String?;
    _educationId = snapshotData['educationId'] as String?;
    _userPhotoAfter = snapshotData['userPhotoAfter'] as String?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education_reviews');

  static Stream<EducationReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EducationReviewsRecord.fromSnapshot(s));

  static Future<EducationReviewsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => EducationReviewsRecord.fromSnapshot(s));

  static EducationReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationReviewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationReviewsRecordData({
  DateTime? createdAt,
  String? reviewBefore,
  String? reviewAfter,
  String? userName,
  String? userPhoto,
  String? educationId,
  String? userPhotoAfter,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'reviewBefore': reviewBefore,
      'reviewAfter': reviewAfter,
      'userName': userName,
      'userPhoto': userPhoto,
      'educationId': educationId,
      'userPhotoAfter': userPhotoAfter,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationReviewsRecordDocumentEquality
    implements Equality<EducationReviewsRecord> {
  const EducationReviewsRecordDocumentEquality();

  @override
  bool equals(EducationReviewsRecord? e1, EducationReviewsRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.reviewBefore == e2?.reviewBefore &&
        e1?.reviewAfter == e2?.reviewAfter &&
        e1?.userName == e2?.userName &&
        e1?.userPhoto == e2?.userPhoto &&
        e1?.educationId == e2?.educationId &&
        e1?.userPhotoAfter == e2?.userPhotoAfter &&
        e1?.index == e2?.index;
  }

  @override
  int hash(EducationReviewsRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.reviewBefore,
        e?.reviewAfter,
        e?.userName,
        e?.userPhoto,
        e?.educationId,
        e?.userPhotoAfter,
        e?.index
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationReviewsRecord;
}
