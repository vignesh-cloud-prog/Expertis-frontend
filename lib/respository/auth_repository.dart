import 'dart:convert';

import 'package:http/http.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Map<String, String> requestHeaders = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    'Content-Type': 'application/json',
  };

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.loginEndPint, requestHeaders, data);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyTokenApi(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.verifyTokenEndPint, header);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      print('object: response ${response.toString()}');
      return response['statusCode'] == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgetPasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.forgetPasswordEndPint, requestHeaders, data);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> changePasswordApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.changePasswordEndPint, requestHeaders, data);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerApiEndPoint, requestHeaders, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyOTP(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.verifyOTPEndPint, requestHeaders, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
