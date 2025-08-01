// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserTypeStruct extends FFFirebaseStruct {
  UserTypeStruct({
    String? userType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userType = userType,
        super(firestoreUtilData);

  // "userType" field.
  String? _userType;
  String get userType => _userType ?? '';
  set userType(String? val) => _userType = val;

  bool hasUserType() => _userType != null;

  static UserTypeStruct fromMap(Map<String, dynamic> data) => UserTypeStruct(
        userType: data['userType'] as String?,
      );

  static UserTypeStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserTypeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userType': _userType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userType': serializeParam(
          _userType,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserTypeStruct(
        userType: deserializeParam(
          data['userType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserTypeStruct && userType == other.userType;
  }

  @override
  int get hashCode => const ListEquality().hash([userType]);
}

UserTypeStruct createUserTypeStruct({
  String? userType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserTypeStruct(
      userType: userType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserTypeStruct? updateUserTypeStruct(
  UserTypeStruct? userTypeStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userTypeStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserTypeStructData(
  Map<String, dynamic> firestoreData,
  UserTypeStruct? userTypeStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userTypeStruct == null) {
    return;
  }
  if (userTypeStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userTypeStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userTypeStructData =
      getUserTypeFirestoreData(userTypeStruct, forFieldValue);
  final nestedData =
      userTypeStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userTypeStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserTypeFirestoreData(
  UserTypeStruct? userTypeStruct, [
  bool forFieldValue = false,
]) {
  if (userTypeStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userTypeStruct.toMap());

  // Add any Firestore field values
  userTypeStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserTypeListFirestoreData(
  List<UserTypeStruct>? userTypeStructs,
) =>
    userTypeStructs?.map((e) => getUserTypeFirestoreData(e, true)).toList() ??
    [];
