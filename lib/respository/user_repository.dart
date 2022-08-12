import 'dart:convert';
import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/models/user_list_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:http/http.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
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

  Future<dynamic> verifyTokenApi() async {
    String token = await UserViewModel.getUserToken();
    // print("Verify toke n: $token");
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.verifyTokenEndPint, requestHeaders);
      if (kDebugMode) {
        // print("response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProfileApi(bool isEditMode, Map<String, String> data,
      bool isFileSelected, Map<String, String> files) async {
    final String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      // print("inside api caller\n");
      // print("data ${data.toString()}");
      // print("files ${files.toString()}");
      // print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getMultipartApiResponse(
          isEditMode,
          ApiUrl.updateProfileApiEndPoint,
          requestHeaders,
          data,
          isFileSelected,
          files);
      if (kDebugMode) {
        // print("response ${response.toString()}");
      }
      if (response != null) {
        return response;
      } else {
        throw FetchDataException('No Internet Connection');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserListModel> fetchUserData() async {
    requestHeaders["Authorization"] = await UserViewModel.getUserToken();
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchUserDataEndPoint, requestHeaders);
      response = UserListModel.fromJson(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteUser(String? id) async {
    final String token = await UserViewModel.getUserToken();

    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      print("inside delete user api caller\n");
      print("data ${id.toString()}");
      print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          ApiUrl.deleteUserEndPoint(id), requestHeaders);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      if (response != null) {
        return response;
      } else {
        throw FetchDataException('No Internet Connection');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addOrRemoveFav(String? id, bool isLiked) async {
    final String token = await UserViewModel.getUserToken();

    requestHeaders["Authorization"] = token;
    // if (kDebugMode) {
    //   print("inside add fav api caller\n");
    //   print(ApiUrl.addOrRemoveFav(id, islike));
    //   // print("data ${id.toString()}");
    //   print("requestHeaders: ${requestHeaders.toString()}");
    // }
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiUrl.addOrRemoveFav(id, isLiked), requestHeaders, null);
      if (kDebugMode) {
        print("response ${response.toString()}");
      }
      if (response != null) {
        return response;
      } else {
        throw FetchDataException('No Internet Connection');
      }
    } catch (e) {
      rethrow;
    }
  }
}
