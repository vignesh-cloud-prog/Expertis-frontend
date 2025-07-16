import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/models/review_list_model.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class ReviewRepository {
  Map<String, String> requestHeaders = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    'Content-Type': 'application/json',
  };

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> createOrUpdateReviewDataApi(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic> files) async {
    final String token = await UserViewModel.getUserToken();
    String url = ApiUrl.reviewEndPoint;
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      // print("inside category api caller\n");
      // print("data ${data.toString()}");
      // print("files ${files.toString()}");
      // print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getMultipartApiResponse(
          false, url, requestHeaders, data, isFileSelected, files);
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

  Future<dynamic> deleteReview(String? id) async {
    final String token = await UserViewModel.getUserToken();
    String url = ApiUrl.tagsEndPoint;
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      // print("inside category delete api caller\n");
      // print("data ${id.toString()}");
      // print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          ApiUrl.deleteShopReviewEndPoint(id), requestHeaders);
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

  Future<ReviewListModel> getAllReviewOfShop(String? id) async {
    final String token = await UserViewModel.getUserToken();
    String url = ApiUrl.getShopReviewEndPoint(id);
    requestHeaders["Authorization"] = token;
    if (kDebugMode) {
      // print("inside category delete api caller\n");
      // print("data ${id.toString()}");
      // print("requestHeaders: ${requestHeaders.toString()}");
    }
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(url, requestHeaders);
      if (kDebugMode) {
        print("response from get shop reviews ${response.toString()}");
      }
      if (response != null) {
        return response = ReviewListModel.fromJson(response);
      } else {
        throw FetchDataException('No Internet Connection');
      }
    } catch (e) {
      rethrow;
    }
  }
}
