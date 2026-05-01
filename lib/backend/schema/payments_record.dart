import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentsRecord extends FirestoreRecord {
  PaymentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "newPrice" field.
  double? _newPrice;
  double get newPrice => _newPrice ?? 0.0;
  bool hasNewPrice() => _newPrice != null;

  // "features" field.
  List<String>? _features;
  List<String> get features => _features ?? const [];
  bool hasFeatures() => _features != null;

  // "newPriceDate" field.
  DateTime? _newPriceDate;
  DateTime? get newPriceDate => _newPriceDate;
  bool hasNewPriceDate() => _newPriceDate != null;

  // "period" field.
  int? _period;
  int get period => _period ?? 0;
  bool hasPeriod() => _period != null;

  // "single" field.
  bool? _single;
  bool get single => _single ?? false;
  bool hasSingle() => _single != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _newPrice = castToType<double>(snapshotData['newPrice']);
    _features = getDataList(snapshotData['features']);
    _newPriceDate = snapshotData['newPriceDate'] as DateTime?;
    _period = castToType<int>(snapshotData['period']);
    _single = snapshotData['single'] as bool?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payments');

  static Stream<PaymentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentsRecord.fromSnapshot(s));

  static Future<PaymentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentsRecord.fromSnapshot(s));

  static PaymentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentsRecordData({
  String? title,
  String? description,
  double? price,
  double? newPrice,
  DateTime? newPriceDate,
  int? period,
  bool? single,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'newPrice': newPrice,
      'newPriceDate': newPriceDate,
      'period': period,
      'single': single,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentsRecordDocumentEquality implements Equality<PaymentsRecord> {
  const PaymentsRecordDocumentEquality();

  @override
  bool equals(PaymentsRecord? e1, PaymentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.price == e2?.price &&
        e1?.newPrice == e2?.newPrice &&
        listEquality.equals(e1?.features, e2?.features) &&
        e1?.newPriceDate == e2?.newPriceDate &&
        e1?.period == e2?.period &&
        e1?.single == e2?.single &&
        e1?.index == e2?.index;
  }

  @override
  int hash(PaymentsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.price,
        e?.newPrice,
        e?.features,
        e?.newPriceDate,
        e?.period,
        e?.single,
        e?.index
      ]);

  @override
  bool isValidKey(Object? o) => o is PaymentsRecord;
}
