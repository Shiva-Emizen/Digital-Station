import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chat_id" field.
  String? _chatId;
  String get chatId => _chatId ?? '';
  bool hasChatId() => _chatId != null;

  // "lastMessage" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "timeStamp" field.
  DateTime? _timeStamp;
  DateTime? get timeStamp => _timeStamp;
  bool hasTimeStamp() => _timeStamp != null;

  // "freelancerId" field.
  String? _freelancerId;
  String get freelancerId => _freelancerId ?? '';
  bool hasFreelancerId() => _freelancerId != null;

  // "clientId" field.
  String? _clientId;
  String get clientId => _clientId ?? '';
  bool hasClientId() => _clientId != null;

  // "clientProfile" field.
  String? _clientProfile;
  String get clientProfile => _clientProfile ?? '';
  bool hasClientProfile() => _clientProfile != null;

  // "freelancerProfile" field.
  String? _freelancerProfile;
  String get freelancerProfile => _freelancerProfile ?? '';
  bool hasFreelancerProfile() => _freelancerProfile != null;

  // "lastUpdated" field.
  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _lastUpdated;
  bool hasLastUpdated() => _lastUpdated != null;

  // "freelancerName" field.
  String? _freelancerName;
  String get freelancerName => _freelancerName ?? '';
  bool hasFreelancerName() => _freelancerName != null;

  // "clientName" field.
  String? _clientName;
  String get clientName => _clientName ?? '';
  bool hasClientName() => _clientName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _chatId = snapshotData['chat_id'] as String?;
    _lastMessage = snapshotData['lastMessage'] as String?;
    _timeStamp = snapshotData['timeStamp'] as DateTime?;
    _freelancerId = snapshotData['freelancerId'] as String?;
    _clientId = snapshotData['clientId'] as String?;
    _clientProfile = snapshotData['clientProfile'] as String?;
    _freelancerProfile = snapshotData['freelancerProfile'] as String?;
    _lastUpdated = snapshotData['lastUpdated'] as DateTime?;
    _freelancerName = snapshotData['freelancerName'] as String?;
    _clientName = snapshotData['clientName'] as String?;
    _email = snapshotData['email'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  String? chatId,
  String? lastMessage,
  DateTime? timeStamp,
  String? freelancerId,
  String? clientId,
  String? clientProfile,
  String? freelancerProfile,
  DateTime? lastUpdated,
  String? freelancerName,
  String? clientName,
  String? email,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chat_id': chatId,
      'lastMessage': lastMessage,
      'timeStamp': timeStamp,
      'freelancerId': freelancerId,
      'clientId': clientId,
      'clientProfile': clientProfile,
      'freelancerProfile': freelancerProfile,
      'lastUpdated': lastUpdated,
      'freelancerName': freelancerName,
      'clientName': clientName,
      'email': email,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    return e1?.chatId == e2?.chatId &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.timeStamp == e2?.timeStamp &&
        e1?.freelancerId == e2?.freelancerId &&
        e1?.clientId == e2?.clientId &&
        e1?.clientProfile == e2?.clientProfile &&
        e1?.freelancerProfile == e2?.freelancerProfile &&
        e1?.lastUpdated == e2?.lastUpdated &&
        e1?.freelancerName == e2?.freelancerName &&
        e1?.clientName == e2?.clientName &&
        e1?.email == e2?.email &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.chatId,
        e?.lastMessage,
        e?.timeStamp,
        e?.freelancerId,
        e?.clientId,
        e?.clientProfile,
        e?.freelancerProfile,
        e?.lastUpdated,
        e?.freelancerName,
        e?.clientName,
        e?.email,
        e?.createdTime
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
