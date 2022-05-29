import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import '../models/login_response_model.dart';

// Obtain shared preferences.

class UserStorage {
  static Future setUserToken(
    LoginResponseModel loginResponse,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    var user = jsonEncode(loginResponse.toJson());
    await prefs.setString('token', user);
  }

  static Future<LoginResponseModel?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      return loginResponseJson(token);
    }
    return null;
  }

  static Future<void> removeUserToken(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token').then((value) => {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          )
        });
  }
}
