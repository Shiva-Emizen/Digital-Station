// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserTypeStruct extends BaseStruct {
  UserTypeStruct({
    String? userType,
  }) : _userType = userType;

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
}) =>
    UserTypeStruct(
      userType: userType,
    );
