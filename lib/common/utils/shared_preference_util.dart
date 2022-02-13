
import 'package:flutter_news/common/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  static Future<void> putString(String key, String value) async {
    LogUtil.println('SharedPref putString [key:$key | value:$value]');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> putInt(String key, int value) async {
    LogUtil.println('SharedPref putInt [key:$key | value:$value]');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<void> putBool(String key, bool value) async {
    LogUtil.println('SharedPref putBool [key:$key | value:$value]');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> putDouble(String key, double value) async {
    LogUtil.println('SharedPref putDouble [key:$key | value:$value]');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<void> putStringList(String key, List<String> value) async {
    LogUtil.println('SharedPref putStringList [key:$key | value:$value]');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    LogUtil.println('SharedPref getString [key:$key | value:$value]');
    return value;
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key) ?? 0;
    LogUtil.println('SharedPref getInt [key:$key | value:$value]');
    return value;
  }
  static Future<int> getIntWithDefault(String key,int defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key) ?? defaultValue;
    LogUtil.println('SharedPref getInt [key:$key | value:$value]');
    return value;
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double value = prefs.getDouble(key) ?? 0;
    LogUtil.println('SharedPref getDouble [key:$key | value:$value]');
    return value;
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    LogUtil.println('SharedPref getBool [key:$key | value:$value]');
    return value;
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> value = prefs.getStringList(key) ?? [];
    LogUtil.println('SharedPref getStringList [key:$key | value:$value]');
    return value;
  }
}
