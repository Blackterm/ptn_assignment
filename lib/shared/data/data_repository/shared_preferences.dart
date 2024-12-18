import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesManager._privateConstructor();

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager._privateConstructor();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }
}
