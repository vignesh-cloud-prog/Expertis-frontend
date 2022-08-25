import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

import '../models/services_list_model.dart';

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

  Future<ShopModel> fetchSelectedShopData(String shopId,
      {bool id = true}) async {
    String token = await UserViewModel.getUserToken();
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;
    String url = ApiUrl.fetchSelectedShopEndPoint(shopId);
    if (!id) {
      url = ApiUrl.fetchSelectedShopEndPointWithShopId(shopId);
    }
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

  Future<ServicesListModel> fetchServicesData(String? shopId) async {
    requestHeaders["Authorization"] = await UserViewModel.getUserToken();
    try {
      print("its in try");
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchServicesDataEndPoint(shopId), requestHeaders);
      print("res ${response}");
      response = ServicesListModel.fromJson(response);
      print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadServiceDataApi(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic?> files) async {
    final String token = await UserViewModel.getUserToken();
    String url = ApiUrl.uploadServiceApiEndPoint;
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      print("inside category api caller\n");
      print("data ${data.toString()}");
      print("files ${files.toString()}");
      print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getMultipartApiResponse(
          isEditMode, url, requestHeaders, data, isFileSelected, files);
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

  Future<dynamic> deleteService(String? id) async {
    final String token = await UserViewModel.getUserToken();

    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      print("inside category delete api caller\n");
      print("data ${id.toString()}");
      print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          ApiUrl.fetchServicesDataEndPoint(id), requestHeaders);
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

  Future<List<dynamic>> fetchSlots(shopId, memberId, date) async {
    final String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchSlotsEndPoint(shopId, memberId, date), requestHeaders);
      print('response: $response');
      print("respones type: ${response.runtimeType}");
      dynamic data = response['data'];
      print("data ${data}");
      List<dynamic>? slots = data.isEmpty ? null : data['slots'];
      return slots ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteShop(String? id) async {
    final String token = await UserViewModel.getUserToken();

    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      print("inside delete shop api caller\n");
      print("data ${id.toString()}");
      print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          ApiUrl.deleteShopEndPoint(id), requestHeaders);
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

  Future<dynamic> fetchShopAnalytics(String? id) async {
    requestHeaders["Authorization"] = await UserViewModel.getUserToken();

    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchShopAnalyticsEndPoint(id), requestHeaders);
      if (kDebugMode) {
        print(" shop analytics response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> incShopViewApi(String? shopId) async {
    requestHeaders["Authorization"] = await UserViewModel.getUserToken();

    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiUrl.incShopViewEndPoint(shopId), requestHeaders, null);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
