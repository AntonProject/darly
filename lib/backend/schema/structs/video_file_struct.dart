// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VideoFileStruct extends FFFirebaseStruct {
  VideoFileStruct({
    String? path,
    String? imagePreview,
    String? duration,
    String? url,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _path = path,
        _imagePreview = imagePreview,
        _duration = duration,
        _url = url,
        super(firestoreUtilData);

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "imagePreview" field.
  String? _imagePreview;
  String get imagePreview => _imagePreview ?? '';
  set imagePreview(String? val) => _imagePreview = val;

  bool hasImagePreview() => _imagePreview != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  set duration(String? val) => _duration = val;

  bool hasDuration() => _duration != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  static VideoFileStruct fromMap(Map<String, dynamic> data) => VideoFileStruct(
        path: data['path'] as String?,
        imagePreview: data['imagePreview'] as String?,
        duration: data['duration'] as String?,
        url: data['url'] as String?,
      );

  static VideoFileStruct? maybeFromMap(dynamic data) => data is Map
      ? VideoFileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'path': _path,
        'imagePreview': _imagePreview,
        'duration': _duration,
        'url': _url,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'imagePreview': serializeParam(
          _imagePreview,
          ParamType.String,
        ),
        'duration': serializeParam(
          _duration,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
      }.withoutNulls;

  static VideoFileStruct fromSerializableMap(Map<String, dynamic> data) =>
      VideoFileStruct(
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        imagePreview: deserializeParam(
          data['imagePreview'],
          ParamType.String,
          false,
        ),
        duration: deserializeParam(
          data['duration'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VideoFileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VideoFileStruct &&
        path == other.path &&
        imagePreview == other.imagePreview &&
        duration == other.duration &&
        url == other.url;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([path, imagePreview, duration, url]);
}

VideoFileStruct createVideoFileStruct({
  String? path,
  String? imagePreview,
  String? duration,
  String? url,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VideoFileStruct(
      path: path,
      imagePreview: imagePreview,
      duration: duration,
      url: url,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VideoFileStruct? updateVideoFileStruct(
  VideoFileStruct? videoFile, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    videoFile
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVideoFileStructData(
  Map<String, dynamic> firestoreData,
  VideoFileStruct? videoFile,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (videoFile == null) {
    return;
  }
  if (videoFile.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && videoFile.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final videoFileData = getVideoFileFirestoreData(videoFile, forFieldValue);
  final nestedData = videoFileData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = videoFile.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVideoFileFirestoreData(
  VideoFileStruct? videoFile, [
  bool forFieldValue = false,
]) {
  if (videoFile == null) {
    return {};
  }
  final firestoreData = mapToFirestore(videoFile.toMap());

  // Add any Firestore field values
  mapToFirestore(videoFile.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVideoFileListFirestoreData(
  List<VideoFileStruct>? videoFiles,
) =>
    videoFiles?.map((e) => getVideoFileFirestoreData(e, true)).toList() ?? [];
