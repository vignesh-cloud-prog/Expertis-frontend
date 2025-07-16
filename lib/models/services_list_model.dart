import 'package:expertis/models/shop_model.dart';

class ServicesListModel {
  List<Services>? services;

  ServicesListModel({this.services});

  ServicesListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      services = <Services>[];
      json['data'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['shops'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
