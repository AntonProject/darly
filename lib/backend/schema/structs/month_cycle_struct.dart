// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthCycleStruct extends FFFirebaseStruct {
  MonthCycleStruct({
    int? menstruationDuration,
    int? cycleDuration,
    List<DateTime>? menstruationDays,
    List<DateTime>? ovulationDays,
    DateTime? month,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _menstruationDuration = menstruationDuration,
        _cycleDuration = cycleDuration,
        _menstruationDays = menstruationDays,
        _ovulationDays = ovulationDays,
        _month = month,
        super(firestoreUtilData);

  // "menstruation_duration" field.
  int? _menstruationDuration;
  int get menstruationDuration => _menstruationDuration ?? 0;
  set menstruationDuration(int? val) => _menstruationDuration = val;

  void incrementMenstruationDuration(int amount) =>
      menstruationDuration = menstruationDuration + amount;

  bool hasMenstruationDuration() => _menstruationDuration != null;

  // "cycle_duration" field.
  int? _cycleDuration;
  int get cycleDuration => _cycleDuration ?? 0;
  set cycleDuration(int? val) => _cycleDuration = val;

  void incrementCycleDuration(int amount) =>
      cycleDuration = cycleDuration + amount;

  bool hasCycleDuration() => _cycleDuration != null;

  // "menstruation_days" field.
  List<DateTime>? _menstruationDays;
  List<DateTime> get menstruationDays => _menstruationDays ?? const [];
  set menstruationDays(List<DateTime>? val) => _menstruationDays = val;

  void updateMenstruationDays(Function(List<DateTime>) updateFn) {
    updateFn(_menstruationDays ??= []);
  }

  bool hasMenstruationDays() => _menstruationDays != null;

  // "ovulation_days" field.
  List<DateTime>? _ovulationDays;
  List<DateTime> get ovulationDays => _ovulationDays ?? const [];
  set ovulationDays(List<DateTime>? val) => _ovulationDays = val;

  void updateOvulationDays(Function(List<DateTime>) updateFn) {
    updateFn(_ovulationDays ??= []);
  }

  bool hasOvulationDays() => _ovulationDays != null;

  // "month" field.
  DateTime? _month;
  DateTime? get month => _month;
  set month(DateTime? val) => _month = val;

  bool hasMonth() => _month != null;

  static MonthCycleStruct fromMap(Map<String, dynamic> data) =>
      MonthCycleStruct(
        menstruationDuration: castToType<int>(data['menstruation_duration']),
        cycleDuration: castToType<int>(data['cycle_duration']),
        menstruationDays: getDataList(data['menstruation_days']),
        ovulationDays: getDataList(data['ovulation_days']),
        month: data['month'] as DateTime?,
      );

  static MonthCycleStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthCycleStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'menstruation_duration': _menstruationDuration,
        'cycle_duration': _cycleDuration,
        'menstruation_days': _menstruationDays,
        'ovulation_days': _ovulationDays,
        'month': _month,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'menstruation_duration': serializeParam(
          _menstruationDuration,
          ParamType.int,
        ),
        'cycle_duration': serializeParam(
          _cycleDuration,
          ParamType.int,
        ),
        'menstruation_days': serializeParam(
          _menstruationDays,
          ParamType.DateTime,
          isList: true,
        ),
        'ovulation_days': serializeParam(
          _ovulationDays,
          ParamType.DateTime,
          isList: true,
        ),
        'month': serializeParam(
          _month,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static MonthCycleStruct fromSerializableMap(Map<String, dynamic> data) =>
      MonthCycleStruct(
        menstruationDuration: deserializeParam(
          data['menstruation_duration'],
          ParamType.int,
          false,
        ),
        cycleDuration: deserializeParam(
          data['cycle_duration'],
          ParamType.int,
          false,
        ),
        menstruationDays: deserializeParam<DateTime>(
          data['menstruation_days'],
          ParamType.DateTime,
          true,
        ),
        ovulationDays: deserializeParam<DateTime>(
          data['ovulation_days'],
          ParamType.DateTime,
          true,
        ),
        month: deserializeParam(
          data['month'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'MonthCycleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MonthCycleStruct &&
        menstruationDuration == other.menstruationDuration &&
        cycleDuration == other.cycleDuration &&
        listEquality.equals(menstruationDays, other.menstruationDays) &&
        listEquality.equals(ovulationDays, other.ovulationDays) &&
        month == other.month;
  }

  @override
  int get hashCode => const ListEquality().hash([
        menstruationDuration,
        cycleDuration,
        menstruationDays,
        ovulationDays,
        month
      ]);
}

MonthCycleStruct createMonthCycleStruct({
  int? menstruationDuration,
  int? cycleDuration,
  DateTime? month,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MonthCycleStruct(
      menstruationDuration: menstruationDuration,
      cycleDuration: cycleDuration,
      month: month,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MonthCycleStruct? updateMonthCycleStruct(
  MonthCycleStruct? monthCycle, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    monthCycle
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMonthCycleStructData(
  Map<String, dynamic> firestoreData,
  MonthCycleStruct? monthCycle,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (monthCycle == null) {
    return;
  }
  if (monthCycle.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && monthCycle.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final monthCycleData = getMonthCycleFirestoreData(monthCycle, forFieldValue);
  final nestedData = monthCycleData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = monthCycle.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMonthCycleFirestoreData(
  MonthCycleStruct? monthCycle, [
  bool forFieldValue = false,
]) {
  if (monthCycle == null) {
    return {};
  }
  final firestoreData = mapToFirestore(monthCycle.toMap());

  // Add any Firestore field values
  mapToFirestore(monthCycle.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMonthCycleListFirestoreData(
  List<MonthCycleStruct>? monthCycles,
) =>
    monthCycles?.map((e) => getMonthCycleFirestoreData(e, true)).toList() ?? [];
