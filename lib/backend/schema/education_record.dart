import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationRecord extends FirestoreRecord {
  EducationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "information" field.
  String? _information;
  String get information => _information ?? '';
  bool hasInformation() => _information != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  bool hasSubtitle() => _subtitle != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "chat_url" field.
  String? _chatUrl;
  String get chatUrl => _chatUrl ?? '';
  bool hasChatUrl() => _chatUrl != null;

  // "news_channel_url" field.
  String? _newsChannelUrl;
  String get newsChannelUrl => _newsChannelUrl ?? '';
  bool hasNewsChannelUrl() => _newsChannelUrl != null;

  // "vip_channel_url" field.
  String? _vipChannelUrl;
  String get vipChannelUrl => _vipChannelUrl ?? '';
  bool hasVipChannelUrl() => _vipChannelUrl != null;

  // "additional_information" field.
  List<String>? _additionalInformation;
  List<String> get additionalInformation => _additionalInformation ?? const [];
  bool hasAdditionalInformation() => _additionalInformation != null;

  // "videoImage" field.
  String? _videoImage;
  String get videoImage => _videoImage ?? '';
  bool hasVideoImage() => _videoImage != null;

  // "preSaleURL" field.
  String? _preSaleURL;
  String get preSaleURL => _preSaleURL ?? '';
  bool hasPreSaleURL() => _preSaleURL != null;

  // "reviewURL" field.
  String? _reviewURL;
  String get reviewURL => _reviewURL ?? '';
  bool hasReviewURL() => _reviewURL != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _image = snapshotData['image'] as String?;
    _information = snapshotData['information'] as String?;
    _subtitle = snapshotData['subtitle'] as String?;
    _description = snapshotData['description'] as String?;
    _video = snapshotData['video'] as String?;
    _chatUrl = snapshotData['chat_url'] as String?;
    _newsChannelUrl = snapshotData['news_channel_url'] as String?;
    _vipChannelUrl = snapshotData['vip_channel_url'] as String?;
    _additionalInformation =
        getDataList(snapshotData['additional_information']);
    _videoImage = snapshotData['videoImage'] as String?;
    _preSaleURL = snapshotData['preSaleURL'] as String?;
    _reviewURL = snapshotData['reviewURL'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('education');

  static Stream<EducationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EducationRecord.fromSnapshot(s));

  static Future<EducationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EducationRecord.fromSnapshot(s));

  static EducationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EducationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EducationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EducationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EducationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EducationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEducationRecordData({
  String? title,
  DateTime? createdAt,
  String? createdBy,
  DateTime? startDate,
  String? image,
  String? information,
  String? subtitle,
  String? description,
  String? video,
  String? chatUrl,
  String? newsChannelUrl,
  String? vipChannelUrl,
  String? videoImage,
  String? preSaleURL,
  String? reviewURL,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'created_at': createdAt,
      'created_by': createdBy,
      'startDate': startDate,
      'image': image,
      'information': information,
      'subtitle': subtitle,
      'description': description,
      'video': video,
      'chat_url': chatUrl,
      'news_channel_url': newsChannelUrl,
      'vip_channel_url': vipChannelUrl,
      'videoImage': videoImage,
      'preSaleURL': preSaleURL,
      'reviewURL': reviewURL,
    }.withoutNulls,
  );

  return firestoreData;
}

class EducationRecordDocumentEquality implements Equality<EducationRecord> {
  const EducationRecordDocumentEquality();

  @override
  bool equals(EducationRecord? e1, EducationRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.startDate == e2?.startDate &&
        e1?.image == e2?.image &&
        e1?.information == e2?.information &&
        e1?.subtitle == e2?.subtitle &&
        e1?.description == e2?.description &&
        e1?.video == e2?.video &&
        e1?.chatUrl == e2?.chatUrl &&
        e1?.newsChannelUrl == e2?.newsChannelUrl &&
        e1?.vipChannelUrl == e2?.vipChannelUrl &&
        listEquality.equals(
            e1?.additionalInformation, e2?.additionalInformation) &&
        e1?.videoImage == e2?.videoImage &&
        e1?.preSaleURL == e2?.preSaleURL &&
        e1?.reviewURL == e2?.reviewURL;
  }

  @override
  int hash(EducationRecord? e) => const ListEquality().hash([
        e?.title,
        e?.createdAt,
        e?.createdBy,
        e?.startDate,
        e?.image,
        e?.information,
        e?.subtitle,
        e?.description,
        e?.video,
        e?.chatUrl,
        e?.newsChannelUrl,
        e?.vipChannelUrl,
        e?.additionalInformation,
        e?.videoImage,
        e?.preSaleURL,
        e?.reviewURL
      ]);

  @override
  bool isValidKey(Object? o) => o is EducationRecord;
}
