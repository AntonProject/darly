import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VideosRecord extends FirestoreRecord {
  VideosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

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

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "videoUrl" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  bool hasVideoUrl() => _videoUrl != null;

  // "views" field.
  int? _views;
  int get views => _views ?? 0;
  bool hasViews() => _views != null;

  // "hide" field.
  bool? _hide;
  bool get hide => _hide ?? false;
  bool hasHide() => _hide != null;

  void _initializeFields() {
    _video = snapshotData['video'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _duration = snapshotData['duration'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _index = castToType<int>(snapshotData['index']);
    _image = snapshotData['image'] as String?;
    _videoUrl = snapshotData['videoUrl'] as String?;
    _views = castToType<int>(snapshotData['views']);
    _hide = snapshotData['hide'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('videos');

  static Stream<VideosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VideosRecord.fromSnapshot(s));

  static Future<VideosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VideosRecord.fromSnapshot(s));

  static VideosRecord fromSnapshot(DocumentSnapshot snapshot) => VideosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VideosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VideosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VideosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VideosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVideosRecordData({
  String? video,
  String? title,
  String? description,
  String? duration,
  DateTime? createdAt,
  String? createdBy,
  int? index,
  String? image,
  String? videoUrl,
  int? views,
  bool? hide,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'video': video,
      'title': title,
      'description': description,
      'duration': duration,
      'created_at': createdAt,
      'created_by': createdBy,
      'index': index,
      'image': image,
      'videoUrl': videoUrl,
      'views': views,
      'hide': hide,
    }.withoutNulls,
  );

  return firestoreData;
}

class VideosRecordDocumentEquality implements Equality<VideosRecord> {
  const VideosRecordDocumentEquality();

  @override
  bool equals(VideosRecord? e1, VideosRecord? e2) {
    return e1?.video == e2?.video &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.duration == e2?.duration &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.index == e2?.index &&
        e1?.image == e2?.image &&
        e1?.videoUrl == e2?.videoUrl &&
        e1?.views == e2?.views &&
        e1?.hide == e2?.hide;
  }

  @override
  int hash(VideosRecord? e) => const ListEquality().hash([
        e?.video,
        e?.title,
        e?.description,
        e?.duration,
        e?.createdAt,
        e?.createdBy,
        e?.index,
        e?.image,
        e?.videoUrl,
        e?.views,
        e?.hide
      ]);

  @override
  bool isValidKey(Object? o) => o is VideosRecord;
}
