import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AudioRecord extends FirestoreRecord {
  AudioRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  // "albumTitle" field.
  String? _albumTitle;
  String get albumTitle => _albumTitle ?? '';
  bool hasAlbumTitle() => _albumTitle != null;

  // "audioTitle" field.
  String? _audioTitle;
  String get audioTitle => _audioTitle ?? '';
  bool hasAudioTitle() => _audioTitle != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "audioPath" field.
  String? _audioPath;
  String get audioPath => _audioPath ?? '';
  bool hasAudioPath() => _audioPath != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "isNew" field.
  bool? _isNew;
  bool get isNew => _isNew ?? false;
  bool hasIsNew() => _isNew != null;

  // "authorTitle" field.
  String? _authorTitle;
  String get authorTitle => _authorTitle ?? '';
  bool hasAuthorTitle() => _authorTitle != null;

  // "exclusive" field.
  bool? _exclusive;
  bool get exclusive => _exclusive ?? false;
  bool hasExclusive() => _exclusive != null;

  // "hide" field.
  bool? _hide;
  bool get hide => _hide ?? false;
  bool hasHide() => _hide != null;

  void _initializeFields() {
    _index = castToType<int>(snapshotData['index']);
    _albumTitle = snapshotData['albumTitle'] as String?;
    _audioTitle = snapshotData['audioTitle'] as String?;
    _duration = snapshotData['duration'] as String?;
    _image = snapshotData['image'] as String?;
    _audioPath = snapshotData['audioPath'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _category = snapshotData['category'] as String?;
    _isNew = snapshotData['isNew'] as bool?;
    _authorTitle = snapshotData['authorTitle'] as String?;
    _exclusive = snapshotData['exclusive'] as bool?;
    _hide = snapshotData['hide'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('audio');

  static Stream<AudioRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AudioRecord.fromSnapshot(s));

  static Future<AudioRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AudioRecord.fromSnapshot(s));

  static AudioRecord fromSnapshot(DocumentSnapshot snapshot) => AudioRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AudioRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AudioRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AudioRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AudioRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAudioRecordData({
  int? index,
  String? albumTitle,
  String? audioTitle,
  String? duration,
  String? image,
  String? audioPath,
  DateTime? createdAt,
  String? createdBy,
  String? category,
  bool? isNew,
  String? authorTitle,
  bool? exclusive,
  bool? hide,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'index': index,
      'albumTitle': albumTitle,
      'audioTitle': audioTitle,
      'duration': duration,
      'image': image,
      'audioPath': audioPath,
      'created_at': createdAt,
      'created_by': createdBy,
      'category': category,
      'isNew': isNew,
      'authorTitle': authorTitle,
      'exclusive': exclusive,
      'hide': hide,
    }.withoutNulls,
  );

  return firestoreData;
}

class AudioRecordDocumentEquality implements Equality<AudioRecord> {
  const AudioRecordDocumentEquality();

  @override
  bool equals(AudioRecord? e1, AudioRecord? e2) {
    return e1?.index == e2?.index &&
        e1?.albumTitle == e2?.albumTitle &&
        e1?.audioTitle == e2?.audioTitle &&
        e1?.duration == e2?.duration &&
        e1?.image == e2?.image &&
        e1?.audioPath == e2?.audioPath &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.category == e2?.category &&
        e1?.isNew == e2?.isNew &&
        e1?.authorTitle == e2?.authorTitle &&
        e1?.exclusive == e2?.exclusive &&
        e1?.hide == e2?.hide;
  }

  @override
  int hash(AudioRecord? e) => const ListEquality().hash([
        e?.index,
        e?.albumTitle,
        e?.audioTitle,
        e?.duration,
        e?.image,
        e?.audioPath,
        e?.createdAt,
        e?.createdBy,
        e?.category,
        e?.isNew,
        e?.authorTitle,
        e?.exclusive,
        e?.hide
      ]);

  @override
  bool isValidKey(Object? o) => o is AudioRecord;
}
