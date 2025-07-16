import 'package:expertis/models/shop_model.dart';

class ShopListModel {
  List<ShopModel>? shops;

  ShopListModel({this.shops});

  ShopListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shops = <ShopModel>[];
      json['data'].forEach((v) {
        shops!.add(ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shops != null) {
      data['shops'] = shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
