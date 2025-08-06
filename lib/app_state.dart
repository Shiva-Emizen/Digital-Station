import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _apitoken = await secureStorage.getString('ff_apitoken') ?? _apitoken;
    });
    await _safeInitAsync(() async {
      _userType = await secureStorage.getString('ff_userType') ?? _userType;
    });
    await _safeInitAsync(() async {
      _features = (await secureStorage.getStringList('ff_features'))
              ?.map((x) {
                try {
                  return FeatureStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _features;
    });
    await _safeInitAsync(() async {
      _appLanguage =
          await secureStorage.getString('ff_appLanguage') ?? _appLanguage;
    });
    await _safeInitAsync(() async {
      _email = await secureStorage.getString('ff_email') ?? _email;
    });
    await _safeInitAsync(() async {
      _password = await secureStorage.getString('ff_password') ?? _password;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _apitoken = '';
  String get apitoken => _apitoken;
  set apitoken(String value) {
    _apitoken = value;
    secureStorage.setString('ff_apitoken', value);
  }

  void deleteApitoken() {
    secureStorage.delete(key: 'ff_apitoken');
  }

  String _userType = '';
  String get userType => _userType;
  set userType(String value) {
    _userType = value;
    secureStorage.setString('ff_userType', value);
  }

  void deleteUserType() {
    secureStorage.delete(key: 'ff_userType');
  }

  List<FeatureStruct> _features = [];
  List<FeatureStruct> get features => _features;
  set features(List<FeatureStruct> value) {
    _features = value;
    secureStorage.setStringList(
        'ff_features', value.map((x) => x.serialize()).toList());
  }

  void deleteFeatures() {
    secureStorage.delete(key: 'ff_features');
  }

  void addToFeatures(FeatureStruct value) {
    features.add(value);
    secureStorage.setStringList(
        'ff_features', _features.map((x) => x.serialize()).toList());
  }

  void removeFromFeatures(FeatureStruct value) {
    features.remove(value);
    secureStorage.setStringList(
        'ff_features', _features.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromFeatures(int index) {
    features.removeAt(index);
    secureStorage.setStringList(
        'ff_features', _features.map((x) => x.serialize()).toList());
  }

  void updateFeaturesAtIndex(
    int index,
    FeatureStruct Function(FeatureStruct) updateFn,
  ) {
    features[index] = updateFn(_features[index]);
    secureStorage.setStringList(
        'ff_features', _features.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInFeatures(int index, FeatureStruct value) {
    features.insert(index, value);
    secureStorage.setStringList(
        'ff_features', _features.map((x) => x.serialize()).toList());
  }

  String _appLanguage = 'en';
  String get appLanguage => _appLanguage;
  set appLanguage(String value) {
    _appLanguage = value;
    secureStorage.setString('ff_appLanguage', value);
  }

  void deleteAppLanguage() {
    secureStorage.delete(key: 'ff_appLanguage');
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    secureStorage.setString('ff_email', value);
  }

  void deleteEmail() {
    secureStorage.delete(key: 'ff_email');
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    secureStorage.setString('ff_password', value);
  }

  void deletePassword() {
    secureStorage.delete(key: 'ff_password');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
