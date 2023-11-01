import 'dart:convert';
import 'package:neobis_auth_project/domain/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Memory {
  saveUser({required User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString(user.login, userJson);
  }

  Future<bool> checkUser({required User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(
        const Duration(seconds: 1)); //For emulation get request
    final value = prefs.getString(user.login);
    if (value == null) {
      return false;
    }
    return true;
  }

  Future<bool> checkUserPassword({required User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(
        const Duration(seconds: 1)); //For emulation get request

    final value = prefs.getString(user.login);
    if (value != null) {
      Map<String, dynamic> jsonMap = json.decode(value);
      if (user.password == jsonMap['password']) {
        return true;
      }
    }
    return false;
  }

  clearMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data in SharedPreferences
  }
}
