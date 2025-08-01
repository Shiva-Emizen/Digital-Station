// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FeatureStruct extends FFFirebaseStruct {
  FeatureStruct({
    String? title,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        super(firestoreUtilData);

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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FeatureStruct(
      title: title,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FeatureStruct? updateFeatureStruct(
  FeatureStruct? feature, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    feature
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFeatureStructData(
  Map<String, dynamic> firestoreData,
  FeatureStruct? feature,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (feature == null) {
    return;
  }
  if (feature.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && feature.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final featureData = getFeatureFirestoreData(feature, forFieldValue);
  final nestedData = featureData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = feature.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFeatureFirestoreData(
  FeatureStruct? feature, [
  bool forFieldValue = false,
]) {
  if (feature == null) {
    return {};
  }
  final firestoreData = mapToFirestore(feature.toMap());

  // Add any Firestore field values
  feature.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFeatureListFirestoreData(
  List<FeatureStruct>? features,
) =>
    features?.map((e) => getFeatureFirestoreData(e, true)).toList() ?? [];
