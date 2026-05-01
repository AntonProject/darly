// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarStruct extends FFFirebaseStruct {
  CalendarStruct({
    List<DateTime>? days,
    DateTime? monthDateTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _days = days,
        _monthDateTime = monthDateTime,
        super(firestoreUtilData);

  // "days" field.
  List<DateTime>? _days;
  List<DateTime> get days => _days ?? const [];
  set days(List<DateTime>? val) => _days = val;

  void updateDays(Function(List<DateTime>) updateFn) {
    updateFn(_days ??= []);
  }

  bool hasDays() => _days != null;

  // "monthDateTime" field.
  DateTime? _monthDateTime;
  DateTime? get monthDateTime => _monthDateTime;
  set monthDateTime(DateTime? val) => _monthDateTime = val;

  bool hasMonthDateTime() => _monthDateTime != null;

  static CalendarStruct fromMap(Map<String, dynamic> data) => CalendarStruct(
        days: getDataList(data['days']),
        monthDateTime: data['monthDateTime'] as DateTime?,
      );

  static CalendarStruct? maybeFromMap(dynamic data) =>
      data is Map ? CalendarStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'days': _days,
        'monthDateTime': _monthDateTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'days': serializeParam(
          _days,
          ParamType.DateTime,
          isList: true,
        ),
        'monthDateTime': serializeParam(
          _monthDateTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static CalendarStruct fromSerializableMap(Map<String, dynamic> data) =>
      CalendarStruct(
        days: deserializeParam<DateTime>(
          data['days'],
          ParamType.DateTime,
          true,
        ),
        monthDateTime: deserializeParam(
          data['monthDateTime'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'CalendarStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStruct &&
        listEquality.equals(days, other.days) &&
        monthDateTime == other.monthDateTime;
  }

  @override
  int get hashCode => const ListEquality().hash([days, monthDateTime]);
}

CalendarStruct createCalendarStruct({
  DateTime? monthDateTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStruct(
      monthDateTime: monthDateTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStruct? updateCalendarStruct(
  CalendarStruct? calendar, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendar
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStructData(
  Map<String, dynamic> firestoreData,
  CalendarStruct? calendar,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendar == null) {
    return;
  }
  if (calendar.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendar.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarData = getCalendarFirestoreData(calendar, forFieldValue);
  final nestedData = calendarData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = calendar.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarFirestoreData(
  CalendarStruct? calendar, [
  bool forFieldValue = false,
]) {
  if (calendar == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendar.toMap());

  // Add any Firestore field values
  mapToFirestore(calendar.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarListFirestoreData(
  List<CalendarStruct>? calendars,
) =>
    calendars?.map((e) => getCalendarFirestoreData(e, true)).toList() ?? [];
