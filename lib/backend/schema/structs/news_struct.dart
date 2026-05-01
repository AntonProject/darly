// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewsStruct extends FFFirebaseStruct {
  NewsStruct({
    String? image,
    String? title,
    String? desc,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _image = image,
        _title = title,
        _desc = desc,
        super(firestoreUtilData);

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "desc" field.
  String? _desc;
  String get desc => _desc ?? '';
  set desc(String? val) => _desc = val;

  bool hasDesc() => _desc != null;

  static NewsStruct fromMap(Map<String, dynamic> data) => NewsStruct(
        image: data['image'] as String?,
        title: data['title'] as String?,
        desc: data['desc'] as String?,
      );

  static NewsStruct? maybeFromMap(dynamic data) =>
      data is Map ? NewsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'image': _image,
        'title': _title,
        'desc': _desc,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'desc': serializeParam(
          _desc,
          ParamType.String,
        ),
      }.withoutNulls;

  static NewsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NewsStruct(
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
        desc: deserializeParam(
          data['desc'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NewsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NewsStruct &&
        image == other.image &&
        title == other.title &&
        desc == other.desc;
  }

  @override
  int get hashCode => const ListEquality().hash([image, title, desc]);
}

NewsStruct createNewsStruct({
  String? image,
  String? title,
  String? desc,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NewsStruct(
      image: image,
      title: title,
      desc: desc,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NewsStruct? updateNewsStruct(
  NewsStruct? news, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    news
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNewsStructData(
  Map<String, dynamic> firestoreData,
  NewsStruct? news,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (news == null) {
    return;
  }
  if (news.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && news.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final newsData = getNewsFirestoreData(news, forFieldValue);
  final nestedData = newsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = news.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNewsFirestoreData(
  NewsStruct? news, [
  bool forFieldValue = false,
]) {
  if (news == null) {
    return {};
  }
  final firestoreData = mapToFirestore(news.toMap());

  // Add any Firestore field values
  mapToFirestore(news.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNewsListFirestoreData(
  List<NewsStruct>? newss,
) =>
    newss?.map((e) => getNewsFirestoreData(e, true)).toList() ?? [];
