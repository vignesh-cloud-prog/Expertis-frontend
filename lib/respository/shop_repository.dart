import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class HomeRepository {
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

  Future<ShopListModel> fetchHomeData() async {
    requestHeaders["Authorization"] = await UserViewModel.getUserToken();
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchHomeDataEndPoint, requestHeaders);
      // print(response);
      response = ShopListModel.fromJson(response);
      // print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ShopListModel> fetchNearbyShopsData() async {
    String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    UserModel user = await UserViewModel.getUser();
    String url = ApiUrl.fetchNearbyShopsEndPoint(user.pinCode, user.address);
    // print("url is $url");
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(url, requestHeaders);
      // print(response);
      response = ShopListModel.fromJson(response);
      // print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ShopModel> fetchSelectedShopData(String shopId) async {
    String token = await UserViewModel.getUserToken();
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;

    String url = ApiUrl.fetchSelectedShopEndPoint(shopId);
    print("url is $url");
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(url, requestHeaders);
      print(response);
      response = ShopModel.fromJson(response["data"]);
      // print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadShopDataApi(bool isEditMode, Map<String, String> data,
      bool isFileSelected, Map<String, dynamic> files) async {
    final String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      print("inside api caller\n");
      print("data ${data.toString()}");
      print("files ${files.toString()}");
      print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getMultipartApiResponse(
          isEditMode,
          ApiUrl.createShopEndPoint,
          requestHeaders,
          data,
          isFileSelected,
          files);
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
