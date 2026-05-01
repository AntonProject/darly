import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NewsRecord extends FirestoreRecord {
  NewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "buttonText" field.
  String? _buttonText;
  String get buttonText => _buttonText ?? '';
  bool hasButtonText() => _buttonText != null;

  // "hide" field.
  bool? _hide;
  bool get hide => _hide ?? false;
  bool hasHide() => _hide != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _text = snapshotData['text'] as String?;
    _image = snapshotData['image'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _createdBy = snapshotData['created_by'] as String?;
    _index = castToType<int>(snapshotData['index']);
    _date = snapshotData['date'] as DateTime?;
    _url = snapshotData['url'] as String?;
    _buttonText = snapshotData['buttonText'] as String?;
    _hide = snapshotData['hide'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('news');

  static Stream<NewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NewsRecord.fromSnapshot(s));

  static Future<NewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NewsRecord.fromSnapshot(s));

  static NewsRecord fromSnapshot(DocumentSnapshot snapshot) => NewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNewsRecordData({
  String? title,
  String? text,
  String? image,
  DateTime? createdAt,
  String? createdBy,
  int? index,
  DateTime? date,
  String? url,
  String? buttonText,
  bool? hide,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'text': text,
      'image': image,
      'created_at': createdAt,
      'created_by': createdBy,
      'index': index,
      'date': date,
      'url': url,
      'buttonText': buttonText,
      'hide': hide,
    }.withoutNulls,
  );

  return firestoreData;
}

class NewsRecordDocumentEquality implements Equality<NewsRecord> {
  const NewsRecordDocumentEquality();

  @override
  bool equals(NewsRecord? e1, NewsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.text == e2?.text &&
        e1?.image == e2?.image &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.index == e2?.index &&
        e1?.date == e2?.date &&
        e1?.url == e2?.url &&
        e1?.buttonText == e2?.buttonText &&
        e1?.hide == e2?.hide;
  }

  @override
  int hash(NewsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.text,
        e?.image,
        e?.createdAt,
        e?.createdBy,
        e?.index,
        e?.date,
        e?.url,
        e?.buttonText,
        e?.hide
      ]);

  @override
  bool isValidKey(Object? o) => o is NewsRecord;
}
