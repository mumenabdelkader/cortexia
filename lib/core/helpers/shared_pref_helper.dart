import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  // ----------------------------------------------------------
  //                🔥 Cached SharedPreferences Instance
  // ----------------------------------------------------------
  static SharedPreferences? _prefs;

  /// MUST BE CALLED IN main() BEFORE runApp()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper initialized.");
  }

  // ----------------------------------------------------------
  //                       🔥 Basic Operations
  // ----------------------------------------------------------

  static Future<void> removeData(String key) async {
    await _prefs?.remove(key);
    debugPrint('SharedPrefHelper : removed key : $key');
  }

  static Future<void> clearAllData() async {
    await _prefs?.clear();
    debugPrint('SharedPrefHelper : all prefs cleared');
  }

  static Future<void> setData(String key, dynamic value) async {
    if (_prefs == null) return;

    debugPrint("SharedPrefHelper : setData : $key = $value");

    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception("Unsupported type ${value.runtimeType}");
    }
  }

  // ----------------------------------------------------------
  //                     🔥 Synchronous Getters
  // ----------------------------------------------------------

  static String getStringSync(String key) {
    return _prefs?.getString(key) ?? "";
  }

  static bool getBoolSync(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  static int getIntSync(String key) {
    return _prefs?.getInt(key) ?? 0;
  }

  // ----------------------------------------------------------
  //                     🔥 Asynchronous Getters
  // ----------------------------------------------------------

  static Future<String> getString(String key) async {
    return _prefs?.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    return _prefs?.getBool(key);
  }

  static Future<int> getInt(String key) async {
    return _prefs?.getInt(key) ?? 0;
  }

  static Future<double> getDouble(String key) async {
    return _prefs?.getDouble(key) ?? 0.0;
  }

  static Future<List<String>> getStringList(String key) async {
    return _prefs?.getStringList(key) ?? [];
  }

  // ----------------------------------------------------------
  //                     🔥 JSON STORAGE
  // ----------------------------------------------------------

  static Future<void> setJson(String key, Map<String, dynamic> value) async {
    await _prefs?.setString(key, jsonEncode(value));
  }

  static Future<Map<String, dynamic>?> getJson(String key) async {
    final data = _prefs?.getString(key);
    if (data == null || data.isEmpty) return null;
    return jsonDecode(data);
  }

  static Future<void> setJsonList(String key, List<Map<String, dynamic>> list) async {
    await _prefs?.setString(key, jsonEncode(list));
  }

  static Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    final jsonString = _prefs?.getString(key);
    if (jsonString == null || jsonString.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => e as Map<String, dynamic>).toList();
  }

  static Future<bool> containsKey(String key) async {
    return _prefs?.containsKey(key) ?? false;
  }

  // ----------------------------------------------------------
  //                  🔐 Flutter Secure Storage
  // ----------------------------------------------------------

  static const _secureStorage = FlutterSecureStorage();

  static Future<void> setSecuredString(String key, String value) async {
    debugPrint("SecureStorage : set : $key = $value");
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    debugPrint("SecureStorage : get : $key");
    return await _secureStorage.read(key: key) ?? "";
  }

  static Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
    debugPrint('SecureStorage : cleared all');
  }
}
