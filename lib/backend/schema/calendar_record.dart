import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarRecord extends FirestoreRecord {
  CalendarRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "monthCycles" field.
  List<MonthCycleStruct>? _monthCycles;
  List<MonthCycleStruct> get monthCycles => _monthCycles ?? const [];
  bool hasMonthCycles() => _monthCycles != null;

  // "firsDate" field.
  DateTime? _firsDate;
  DateTime? get firsDate => _firsDate;
  bool hasFirsDate() => _firsDate != null;

  // "duration" field.
  int? _duration;
  int get duration => _duration ?? 0;
  bool hasDuration() => _duration != null;

  // "lengthCycle" field.
  int? _lengthCycle;
  int get lengthCycle => _lengthCycle ?? 0;
  bool hasLengthCycle() => _lengthCycle != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  void _initializeFields() {
    _monthCycles = getStructList(
      snapshotData['monthCycles'],
      MonthCycleStruct.fromMap,
    );
    _firsDate = snapshotData['firsDate'] as DateTime?;
    _duration = castToType<int>(snapshotData['duration']);
    _lengthCycle = castToType<int>(snapshotData['lengthCycle']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calendar');

  static Stream<CalendarRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalendarRecord.fromSnapshot(s));

  static Future<CalendarRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalendarRecord.fromSnapshot(s));

  static CalendarRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalendarRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalendarRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalendarRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalendarRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalendarRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalendarRecordData({
  DateTime? firsDate,
  int? duration,
  int? lengthCycle,
  DateTime? createdAt,
  String? createdBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'firsDate': firsDate,
      'duration': duration,
      'lengthCycle': lengthCycle,
      'created_at': createdAt,
      'created_by': createdBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class CalendarRecordDocumentEquality implements Equality<CalendarRecord> {
  const CalendarRecordDocumentEquality();

  @override
  bool equals(CalendarRecord? e1, CalendarRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.monthCycles, e2?.monthCycles) &&
        e1?.firsDate == e2?.firsDate &&
        e1?.duration == e2?.duration &&
        e1?.lengthCycle == e2?.lengthCycle &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy;
  }

  @override
  int hash(CalendarRecord? e) => const ListEquality().hash([
        e?.monthCycles,
        e?.firsDate,
        e?.duration,
        e?.lengthCycle,
        e?.createdAt,
        e?.createdBy
      ]);

  @override
  bool isValidKey(Object? o) => o is CalendarRecord;
}
