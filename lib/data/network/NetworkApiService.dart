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
      print("data ${data.toString()}");
    }
    try {
      Response response = await http
          .post(Uri.parse(url), headers: header, body: data)
          .timeout(Duration(seconds: 30));

      if (kDebugMode) {
        print("response ${response.body}");
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);
    responseJson["statusCode"] = response.statusCode;
    switch (response.statusCode) {
      case 200:
        return responseJson;

      case 400:
        throw BadRequestException(responseJson['message']);
      case 500:
      case 404:
        throw UnauthorisedException(responseJson['message']);
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
