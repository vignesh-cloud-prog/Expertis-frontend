import 'dart:convert';

import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/send_otp_response_model.dart';
import 'package:http/http.dart' as http;

import '../assets/config.dart' as constants;
import './user_storage.dart';

class APIService {
  static var client = http.Client();

  static Future login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      constants.apiURL,
      constants.loginAPI,
    );

    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    var data = jsonDecode(response.body);
    print("printing ${data['message']}");

    if (response.statusCode == 200) {
      await UserStorage.setUserToken(
        loginResponseJson(
          response.body,
        ),
      );

      return data;
    } else {
      return data;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      constants.apiURL,
      constants.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await UserStorage.getUserToken();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(constants.apiURL, constants.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<SendOTPResponseModel> otpLogin(String email) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(constants.apiURL, constants.sendOTPAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email}),
    );

    print("send otp ${response.body}");

    return sendOTPResponseJson(response.body);
  }

  static Future<LoginResponseModel> verifyOtp(
    String email,
    String otpHash,
    String otpCode,
  ) async {
    print(" data ${email}, ${otpHash}, ${otpCode}");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(constants.apiURL, constants.verifyOTPAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "otp": otpCode, "hash": otpHash}),
    );
    print("verify otp ${response.body}");
    return loginResponseJson(response.body);
  }
}
