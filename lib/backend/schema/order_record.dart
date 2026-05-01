import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderRecord extends FirestoreRecord {
  OrderRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "rlUser" field.
  DocumentReference? _rlUser;
  DocumentReference? get rlUser => _rlUser;
  bool hasRlUser() => _rlUser != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  bool hasCurrency() => _currency != null;

  // "client_email" field.
  String? _clientEmail;
  String get clientEmail => _clientEmail ?? '';
  bool hasClientEmail() => _clientEmail != null;

  // "payment_id" field.
  String? _paymentId;
  String get paymentId => _paymentId ?? '';
  bool hasPaymentId() => _paymentId != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  bool hasPaid() => _paid != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "cancel_date" field.
  DateTime? _cancelDate;
  DateTime? get cancelDate => _cancelDate;
  bool hasCancelDate() => _cancelDate != null;

  // "transaction_id" field.
  String? _transactionId;
  String get transactionId => _transactionId ?? '';
  bool hasTransactionId() => _transactionId != null;

  // "recurrent_interval" field.
  String? _recurrentInterval;
  String get recurrentInterval => _recurrentInterval ?? '';
  bool hasRecurrentInterval() => _recurrentInterval != null;

  // "recurrent_period" field.
  int? _recurrentPeriod;
  int get recurrentPeriod => _recurrentPeriod ?? 0;
  bool hasRecurrentPeriod() => _recurrentPeriod != null;

  // "subcription_id" field.
  String? _subcriptionId;
  String get subcriptionId => _subcriptionId ?? '';
  bool hasSubcriptionId() => _subcriptionId != null;

  // "client_id" field.
  String? _clientId;
  String get clientId => _clientId ?? '';
  bool hasClientId() => _clientId != null;

  void _initializeFields() {
    _rlUser = snapshotData['rlUser'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _description = snapshotData['description'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _currency = snapshotData['currency'] as String?;
    _clientEmail = snapshotData['client_email'] as String?;
    _paymentId = snapshotData['payment_id'] as String?;
    _paid = snapshotData['paid'] as bool?;
    _amount = castToType<int>(snapshotData['amount']);
    _cancelDate = snapshotData['cancel_date'] as DateTime?;
    _transactionId = snapshotData['transaction_id'] as String?;
    _recurrentInterval = snapshotData['recurrent_interval'] as String?;
    _recurrentPeriod = castToType<int>(snapshotData['recurrent_period']);
    _subcriptionId = snapshotData['subcription_id'] as String?;
    _clientId = snapshotData['client_id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('order');

  static Stream<OrderRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrderRecord.fromSnapshot(s));

  static Future<OrderRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrderRecord.fromSnapshot(s));

  static OrderRecord fromSnapshot(DocumentSnapshot snapshot) => OrderRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrderRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrderRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrderRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrderRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrderRecordData({
  DocumentReference? rlUser,
  DateTime? date,
  String? status,
  String? description,
  double? price,
  String? currency,
  String? clientEmail,
  String? paymentId,
  bool? paid,
  int? amount,
  DateTime? cancelDate,
  String? transactionId,
  String? recurrentInterval,
  int? recurrentPeriod,
  String? subcriptionId,
  String? clientId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'rlUser': rlUser,
      'date': date,
      'status': status,
      'description': description,
      'price': price,
      'currency': currency,
      'client_email': clientEmail,
      'payment_id': paymentId,
      'paid': paid,
      'amount': amount,
      'cancel_date': cancelDate,
      'transaction_id': transactionId,
      'recurrent_interval': recurrentInterval,
      'recurrent_period': recurrentPeriod,
      'subcription_id': subcriptionId,
      'client_id': clientId,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrderRecordDocumentEquality implements Equality<OrderRecord> {
  const OrderRecordDocumentEquality();

  @override
  bool equals(OrderRecord? e1, OrderRecord? e2) {
    return e1?.rlUser == e2?.rlUser &&
        e1?.date == e2?.date &&
        e1?.status == e2?.status &&
        e1?.description == e2?.description &&
        e1?.price == e2?.price &&
        e1?.currency == e2?.currency &&
        e1?.clientEmail == e2?.clientEmail &&
        e1?.paymentId == e2?.paymentId &&
        e1?.paid == e2?.paid &&
        e1?.amount == e2?.amount &&
        e1?.cancelDate == e2?.cancelDate &&
        e1?.transactionId == e2?.transactionId &&
        e1?.recurrentInterval == e2?.recurrentInterval &&
        e1?.recurrentPeriod == e2?.recurrentPeriod &&
        e1?.subcriptionId == e2?.subcriptionId &&
        e1?.clientId == e2?.clientId;
  }

  @override
  int hash(OrderRecord? e) => const ListEquality().hash([
        e?.rlUser,
        e?.date,
        e?.status,
        e?.description,
        e?.price,
        e?.currency,
        e?.clientEmail,
        e?.paymentId,
        e?.paid,
        e?.amount,
        e?.cancelDate,
        e?.transactionId,
        e?.recurrentInterval,
        e?.recurrentPeriod,
        e?.subcriptionId,
        e?.clientId
      ]);

  @override
  bool isValidKey(Object? o) => o is OrderRecord;
}
