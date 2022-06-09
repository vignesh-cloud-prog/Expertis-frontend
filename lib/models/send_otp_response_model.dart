import 'dart:convert';

SendOTPResponseModel sendOTPResponseJson(String str) =>
    SendOTPResponseModel.fromJson(json.decode(str));

class SendOTPResponseModel {
  SendOTPResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final String? data;

  SendOTPResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data;
    return _data;
  }
}
