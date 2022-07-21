import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:expertis/data/app_excaptions.dart';
import 'package:expertis/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, dynamic header) async {
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print("url $url");
        print("header $header");
      }
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 60));
      if (kDebugMode) {
        // print("response ${response.body}");
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic header, dynamic data) async {
    dynamic responseJson;

    if (kDebugMode) {
      // print("data ${data.toString()}");
    }
    try {
      Response response = await http
          .post(Uri.parse(url), headers: header, body: data)
          .timeout(Duration(seconds: 30));

      if (kDebugMode) {
        // print("response ${response.body}");
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getMultipartApiResponse(
      bool isEditMode,
      String url,
      Map<String, String> header,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, String> files) async {
    dynamic responseJson;
    // print("isFileSelected $isFileSelected");
    try {
      var requestMethod = isEditMode ? "PATCH" : "POST";

      var request = http.MultipartRequest(requestMethod, Uri.parse(url));
      request.fields.addAll(data);
      request.headers.addAll(header);

      if (isFileSelected) {
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value));
        });
      }

      var response = await request.send();
      // print(response.statusCode);

      var responded = await http.Response.fromStream(response);
      // print(responded.body);
      return responseJson = returnResponse(responded);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 300:
        responseJson["statusCode"] = response.statusCode;
        return responseJson;
      case 401:
        throw TokenExpiredException(responseJson["message"]);
      case 403:
        throw UnauthorizedException(responseJson["message"]);
      case 400:
        throw BadRequestException(responseJson['message']);
      case 500:
      case 404:
        throw UnauthorizedException(responseJson['message']);
      default:
        throw FetchDataException(
            'Error occulted while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
