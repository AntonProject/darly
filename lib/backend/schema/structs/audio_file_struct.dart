// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AudioFileStruct extends FFFirebaseStruct {
  AudioFileStruct({
    String? audioPath,
    String? image,
    String? title,
    String? author,
    int? index,
    String? duration,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _audioPath = audioPath,
        _image = image,
        _title = title,
        _author = author,
        _index = index,
        _duration = duration,
        super(firestoreUtilData);

  // "audioPath" field.
  String? _audioPath;
  String get audioPath => _audioPath ?? '';
  set audioPath(String? val) => _audioPath = val;

  bool hasAudioPath() => _audioPath != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "title" field.
  String? _title;
  String get title => _title ?? 'unknown';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "author" field.
  String? _author;
  String get author => _author ?? 'unnamed';
  set author(String? val) => _author = val;

  bool hasAuthor() => _author != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  set index(int? val) => _index = val;

  void incrementIndex(int amount) => index = index + amount;

  bool hasIndex() => _index != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '00:00';
  set duration(String? val) => _duration = val;

  bool hasDuration() => _duration != null;

  static AudioFileStruct fromMap(Map<String, dynamic> data) => AudioFileStruct(
        audioPath: data['audioPath'] as String?,
        image: data['image'] as String?,
        title: data['title'] as String?,
        author: data['author'] as String?,
        index: castToType<int>(data['index']),
        duration: data['duration'] as String?,
      );

  static AudioFileStruct? maybeFromMap(dynamic data) => data is Map
      ? AudioFileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'audioPath': _audioPath,
        'image': _image,
        'title': _title,
        'author': _author,
        'index': _index,
        'duration': _duration,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'audioPath': serializeParam(
          _audioPath,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'author': serializeParam(
          _author,
          ParamType.String,
        ),
        'index': serializeParam(
          _index,
          ParamType.int,
        ),
        'duration': serializeParam(
          _duration,
          ParamType.String,
        ),
      }.withoutNulls;

  static AudioFileStruct fromSerializableMap(Map<String, dynamic> data) =>
      AudioFileStruct(
        audioPath: deserializeParam(
          data['audioPath'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        author: deserializeParam(
          data['author'],
          ParamType.String,
          false,
        ),
        index: deserializeParam(
          data['index'],
          ParamType.int,
          false,
        ),
        duration: deserializeParam(
          data['duration'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AudioFileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AudioFileStruct &&
        audioPath == other.audioPath &&
        image == other.image &&
        title == other.title &&
        author == other.author &&
        index == other.index &&
        duration == other.duration;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([audioPath, image, title, author, index, duration]);
}

AudioFileStruct createAudioFileStruct({
  String? audioPath,
  String? image,
  String? title,
  String? author,
  int? index,
  String? duration,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AudioFileStruct(
      audioPath: audioPath,
      image: image,
      title: title,
      author: author,
      index: index,
      duration: duration,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AudioFileStruct? updateAudioFileStruct(
  AudioFileStruct? audioFile, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    audioFile
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAudioFileStructData(
  Map<String, dynamic> firestoreData,
  AudioFileStruct? audioFile,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (audioFile == null) {
    return;
  }
  if (audioFile.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && audioFile.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final audioFileData = getAudioFileFirestoreData(audioFile, forFieldValue);
  final nestedData = audioFileData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = audioFile.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAudioFileFirestoreData(
  AudioFileStruct? audioFile, [
  bool forFieldValue = false,
]) {
  if (audioFile == null) {
    return {};
  }
  final firestoreData = mapToFirestore(audioFile.toMap());

  // Add any Firestore field values
  mapToFirestore(audioFile.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAudioFileListFirestoreData(
  List<AudioFileStruct>? audioFiles,
) =>
    audioFiles?.map((e) => getAudioFileFirestoreData(e, true)).toList() ?? [];
