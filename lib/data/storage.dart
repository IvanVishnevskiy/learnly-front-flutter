import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<Map> get(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedJSON = prefs.getString(name);
    if (savedJSON == null) return Map();
    return jsonDecode(savedJSON);
  }

  static Future<bool> set(String name, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool saved = await prefs.setString(name, jsonEncode(value));

    return saved;
  }
}
