import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:expertis/data/network/NetworkApiService.dart';
import 'package:expertis/models/appointment_list_model.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/utils/api_url.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class AppointmentRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Map<String, String> requestHeaders = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    'Content-Type': 'application/json',
  };

  Future<AppointmentListModel> fetchUserAppointments(
      String userId, bool past) async {
    final String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchUserAppointmentsEndPoint(userId, past), requestHeaders);
      print(response.runtimeType);
      response = AppointmentListModel.fromJson(response);
      // print("\n\nresponse after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppointmentListModel> fetchShopAppointments(
      String shopId, bool upcoming) async {
    final String token = await UserViewModel.getUserToken();
    requestHeaders["Authorization"] = token;
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiUrl.fetchShopAppointmentsEndPoint(shopId, upcoming),
          requestHeaders);
      print(response.runtimeType);
      response = AppointmentListModel.fromJson(response);
      // print("\n\nresponse after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> bookAppointment(dynamic data) async {
    String token = await UserViewModel.getUserToken();
    // print("Verify toke n: $token");
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;

    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiUrl.bookAppointmentEndPoint, requestHeaders, data);
      if (kDebugMode) {
        // print("response ${response.toString()}");
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppointmentModel> fetchSelectedAppointment(
      String appointmentId) async {
    String token = await UserViewModel.getUserToken();
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;

    String url = ApiUrl.fetchSelectedAppointmentEndPoint(appointmentId);
    print("url is $url");
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(url, requestHeaders);
      print("Appointment response ");
      print(response["data"]);
      response = AppointmentModel.fromJson(response["data"]);
      print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppointmentModel> updateAppointmentStatus(
      String appointmentId, String status) async {
    String token = await UserViewModel.getUserToken();
    if (token == 'dummy' || token.isEmpty) {
      throw TokenNotFoundException();
    }
    requestHeaders["Authorization"] = token;
    print('status in reposiytoy $status');
    String url = ApiUrl.fetchSelectedAppointmentEndPoint(appointmentId);
    if (status.toLowerCase() == "cancel") {
      url = ApiUrl.cancelAppointmentEndPointWithId(appointmentId);
    } else if (status.toLowerCase() == "complete") {
      url = ApiUrl.completeAppointmentEndPointWithId(appointmentId);
    } else if (status.toLowerCase() == "accept") {
      url = ApiUrl.acceptAppointmentEndPointWithId(appointmentId);
    } else if (status.toLowerCase() == "reject") {
      url = ApiUrl.rejectAppointmentEndPointWithId(appointmentId);
    }

    print("url is $url");
    try {
      dynamic response =
          await _apiServices.getPatchApiResponse(url, requestHeaders, null);
      print("Appointment response ");
      print(response["data"]);
      response = AppointmentModel.fromJson(response["data"]);
      print("response after from json ${response.toString()}");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
