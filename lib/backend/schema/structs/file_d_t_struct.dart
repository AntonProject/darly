// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FileDTStruct extends FFFirebaseStruct {
  FileDTStruct({
    String? name,
    double? sizeMB,
    String? type,
    String? path,
    DateTime? updated,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _sizeMB = sizeMB,
        _type = type,
        _path = path,
        _updated = updated,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? 'unknown';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "sizeMB" field.
  double? _sizeMB;
  double get sizeMB => _sizeMB ?? 0.0;
  set sizeMB(double? val) => _sizeMB = val;

  void incrementSizeMB(double amount) => sizeMB = sizeMB + amount;

  bool hasSizeMB() => _sizeMB != null;

  // "type" field.
  String? _type;
  String get type => _type ?? 'PDF';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "updated" field.
  DateTime? _updated;
  DateTime? get updated => _updated;
  set updated(DateTime? val) => _updated = val;

  bool hasUpdated() => _updated != null;

  static FileDTStruct fromMap(Map<String, dynamic> data) => FileDTStruct(
        name: data['name'] as String?,
        sizeMB: castToType<double>(data['sizeMB']),
        type: data['type'] as String?,
        path: data['path'] as String?,
        updated: data['updated'] as DateTime?,
      );

  static FileDTStruct? maybeFromMap(dynamic data) =>
      data is Map ? FileDTStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'sizeMB': _sizeMB,
        'type': _type,
        'path': _path,
        'updated': _updated,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'sizeMB': serializeParam(
          _sizeMB,
          ParamType.double,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'updated': serializeParam(
          _updated,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static FileDTStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileDTStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        sizeMB: deserializeParam(
          data['sizeMB'],
          ParamType.double,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        updated: deserializeParam(
          data['updated'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'FileDTStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileDTStruct &&
        name == other.name &&
        sizeMB == other.sizeMB &&
        type == other.type &&
        path == other.path &&
        updated == other.updated;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, sizeMB, type, path, updated]);
}

FileDTStruct createFileDTStruct({
  String? name,
  double? sizeMB,
  String? type,
  String? path,
  DateTime? updated,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileDTStruct(
      name: name,
      sizeMB: sizeMB,
      type: type,
      path: path,
      updated: updated,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileDTStruct? updateFileDTStruct(
  FileDTStruct? fileDT, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileDT
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileDTStructData(
  Map<String, dynamic> firestoreData,
  FileDTStruct? fileDT,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileDT == null) {
    return;
  }
  if (fileDT.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileDT.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileDTData = getFileDTFirestoreData(fileDT, forFieldValue);
  final nestedData = fileDTData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileDT.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileDTFirestoreData(
  FileDTStruct? fileDT, [
  bool forFieldValue = false,
]) {
  if (fileDT == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileDT.toMap());

  // Add any Firestore field values
  mapToFirestore(fileDT.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileDTListFirestoreData(
  List<FileDTStruct>? fileDTs,
) =>
    fileDTs?.map((e) => getFileDTFirestoreData(e, true)).toList() ?? [];
