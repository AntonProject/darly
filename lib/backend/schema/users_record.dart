import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "countryCode" field.
  String? _countryCode;
  String get countryCode => _countryCode ?? '';
  bool hasCountryCode() => _countryCode != null;

  // "birthDay" field.
  DateTime? _birthDay;
  DateTime? get birthDay => _birthDay;
  bool hasBirthDay() => _birthDay != null;

  // "surname" field.
  String? _surname;
  String get surname => _surname ?? '';
  bool hasSurname() => _surname != null;

  // "deleted" field.
  bool? _deleted;
  bool get deleted => _deleted ?? false;
  bool hasDeleted() => _deleted != null;

  // "messageLetterDay" field.
  String? _messageLetterDay;
  String get messageLetterDay => _messageLetterDay ?? '';
  bool hasMessageLetterDay() => _messageLetterDay != null;

  // "messageLetterDate" field.
  DateTime? _messageLetterDate;
  DateTime? get messageLetterDate => _messageLetterDate;
  bool hasMessageLetterDate() => _messageLetterDate != null;

  // "wishAudioList" field.
  List<String>? _wishAudioList;
  List<String> get wishAudioList => _wishAudioList ?? const [];
  bool hasWishAudioList() => _wishAudioList != null;

  // "subscription_expDate" field.
  DateTime? _subscriptionExpDate;
  DateTime? get subscriptionExpDate => _subscriptionExpDate;
  bool hasSubscriptionExpDate() => _subscriptionExpDate != null;

  // "subscription_id" field.
  String? _subscriptionId;
  String get subscriptionId => _subscriptionId ?? '';
  bool hasSubscriptionId() => _subscriptionId != null;

  // "subscription_nextTransactionDate" field.
  DateTime? _subscriptionNextTransactionDate;
  DateTime? get subscriptionNextTransactionDate =>
      _subscriptionNextTransactionDate;
  bool hasSubscriptionNextTransactionDate() =>
      _subscriptionNextTransactionDate != null;

  // "education_subscription_expDate" field.
  DateTime? _educationSubscriptionExpDate;
  DateTime? get educationSubscriptionExpDate => _educationSubscriptionExpDate;
  bool hasEducationSubscriptionExpDate() =>
      _educationSubscriptionExpDate != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "lessonsUser" field.
  List<DocumentReference>? _lessonsUser;
  List<DocumentReference> get lessonsUser => _lessonsUser ?? const [];
  bool hasLessonsUser() => _lessonsUser != null;

  // "messageLetterDayImage" field.
  String? _messageLetterDayImage;
  String get messageLetterDayImage => _messageLetterDayImage ?? '';
  bool hasMessageLetterDayImage() => _messageLetterDayImage != null;

  // "practicOfDay" field.
  DocumentReference? _practicOfDay;
  DocumentReference? get practicOfDay => _practicOfDay;
  bool hasPracticOfDay() => _practicOfDay != null;

  // "practicOfDayDate" field.
  DateTime? _practicOfDayDate;
  DateTime? get practicOfDayDate => _practicOfDayDate;
  bool hasPracticOfDayDate() => _practicOfDayDate != null;

  // "education_subcription_id" field.
  String? _educationSubcriptionId;
  String get educationSubcriptionId => _educationSubcriptionId ?? '';
  bool hasEducationSubcriptionId() => _educationSubcriptionId != null;

  // "messageShown" field.
  List<String>? _messageShown;
  List<String> get messageShown => _messageShown ?? const [];
  bool hasMessageShown() => _messageShown != null;

  // "last_listened_at" field.
  DateTime? _lastListenedAt;
  DateTime? get lastListenedAt => _lastListenedAt;
  bool hasLastListenedAt() => _lastListenedAt != null;

  // "last_login_at" field.
  DateTime? _lastLoginAt;
  DateTime? get lastLoginAt => _lastLoginAt;
  bool hasLastLoginAt() => _lastLoginAt != null;

  // "educationSubsId" field.
  String? _educationSubsId;
  String get educationSubsId => _educationSubsId ?? '';
  bool hasEducationSubsId() => _educationSubsId != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _country = snapshotData['country'] as String?;
    _countryCode = snapshotData['countryCode'] as String?;
    _birthDay = snapshotData['birthDay'] as DateTime?;
    _surname = snapshotData['surname'] as String?;
    _deleted = snapshotData['deleted'] as bool?;
    _messageLetterDay = snapshotData['messageLetterDay'] as String?;
    _messageLetterDate = snapshotData['messageLetterDate'] as DateTime?;
    _wishAudioList = getDataList(snapshotData['wishAudioList']);
    _subscriptionExpDate = snapshotData['subscription_expDate'] as DateTime?;
    _subscriptionId = snapshotData['subscription_id'] as String?;
    _subscriptionNextTransactionDate =
        snapshotData['subscription_nextTransactionDate'] as DateTime?;
    _educationSubscriptionExpDate =
        snapshotData['education_subscription_expDate'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _lessonsUser = getDataList(snapshotData['lessonsUser']);
    _messageLetterDayImage = snapshotData['messageLetterDayImage'] as String?;
    _practicOfDay = snapshotData['practicOfDay'] as DocumentReference?;
    _practicOfDayDate = snapshotData['practicOfDayDate'] as DateTime?;
    _educationSubcriptionId =
        snapshotData['education_subcription_id'] as String?;
    _messageShown = getDataList(snapshotData['messageShown']);
    _lastListenedAt = snapshotData['last_listened_at'] as DateTime?;
    _lastLoginAt = snapshotData['last_login_at'] as DateTime?;
    _educationSubsId = snapshotData['educationSubsId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? country,
  String? countryCode,
  DateTime? birthDay,
  String? surname,
  bool? deleted,
  String? messageLetterDay,
  DateTime? messageLetterDate,
  DateTime? subscriptionExpDate,
  String? subscriptionId,
  DateTime? subscriptionNextTransactionDate,
  DateTime? educationSubscriptionExpDate,
  String? role,
  String? messageLetterDayImage,
  DocumentReference? practicOfDay,
  DateTime? practicOfDayDate,
  String? educationSubcriptionId,
  DateTime? lastListenedAt,
  DateTime? lastLoginAt,
  String? educationSubsId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'country': country,
      'countryCode': countryCode,
      'birthDay': birthDay,
      'surname': surname,
      'deleted': deleted,
      'messageLetterDay': messageLetterDay,
      'messageLetterDate': messageLetterDate,
      'subscription_expDate': subscriptionExpDate,
      'subscription_id': subscriptionId,
      'subscription_nextTransactionDate': subscriptionNextTransactionDate,
      'education_subscription_expDate': educationSubscriptionExpDate,
      'role': role,
      'messageLetterDayImage': messageLetterDayImage,
      'practicOfDay': practicOfDay,
      'practicOfDayDate': practicOfDayDate,
      'education_subcription_id': educationSubcriptionId,
      'last_listened_at': lastListenedAt,
      'last_login_at': lastLoginAt,
      'educationSubsId': educationSubsId,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.country == e2?.country &&
        e1?.countryCode == e2?.countryCode &&
        e1?.birthDay == e2?.birthDay &&
        e1?.surname == e2?.surname &&
        e1?.deleted == e2?.deleted &&
        e1?.messageLetterDay == e2?.messageLetterDay &&
        e1?.messageLetterDate == e2?.messageLetterDate &&
        listEquality.equals(e1?.wishAudioList, e2?.wishAudioList) &&
        e1?.subscriptionExpDate == e2?.subscriptionExpDate &&
        e1?.subscriptionId == e2?.subscriptionId &&
        e1?.subscriptionNextTransactionDate ==
            e2?.subscriptionNextTransactionDate &&
        e1?.educationSubscriptionExpDate == e2?.educationSubscriptionExpDate &&
        e1?.role == e2?.role &&
        listEquality.equals(e1?.lessonsUser, e2?.lessonsUser) &&
        e1?.messageLetterDayImage == e2?.messageLetterDayImage &&
        e1?.practicOfDay == e2?.practicOfDay &&
        e1?.practicOfDayDate == e2?.practicOfDayDate &&
        e1?.educationSubcriptionId == e2?.educationSubcriptionId &&
        listEquality.equals(e1?.messageShown, e2?.messageShown) &&
        e1?.lastListenedAt == e2?.lastListenedAt &&
        e1?.lastLoginAt == e2?.lastLoginAt &&
        e1?.educationSubsId == e2?.educationSubsId;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.country,
        e?.countryCode,
        e?.birthDay,
        e?.surname,
        e?.deleted,
        e?.messageLetterDay,
        e?.messageLetterDate,
        e?.wishAudioList,
        e?.subscriptionExpDate,
        e?.subscriptionId,
        e?.subscriptionNextTransactionDate,
        e?.educationSubscriptionExpDate,
        e?.role,
        e?.lessonsUser,
        e?.messageLetterDayImage,
        e?.practicOfDay,
        e?.practicOfDayDate,
        e?.educationSubcriptionId,
        e?.messageShown,
        e?.lastListenedAt,
        e?.lastLoginAt,
        e?.educationSubsId
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
