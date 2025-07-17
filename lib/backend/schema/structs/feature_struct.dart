// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeatureStruct extends BaseStruct {
  FeatureStruct({
    String? title,
  }) : _title = title;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static FeatureStruct fromMap(Map<String, dynamic> data) => FeatureStruct(
        title: data['title'] as String?,
      );

  static FeatureStruct? maybeFromMap(dynamic data) =>
      data is Map ? FeatureStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static FeatureStruct fromSerializableMap(Map<String, dynamic> data) =>
      FeatureStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FeatureStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FeatureStruct && title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([title]);
}

FeatureStruct createFeatureStruct({
  String? title,
}) =>
    FeatureStruct(
      title: title,
    );
