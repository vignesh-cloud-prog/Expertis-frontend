import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/shop_model.dart';

import 'user_model.dart';

class AppointmentModel {
  ShopModel? shopId;
  String? memberId;
  UserModel? userId;
  int? totalPrice;
  int? totalTime;
  String? paymentStatus;
  String? appointmentStatus;
  List<String> selectedServices = [];
  List<Services>? services;
  List<int>? slots;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  String? id;

  AppointmentModel(
      {this.shopId,
      this.memberId,
      this.userId,
      this.totalPrice,
      this.totalTime,
      this.paymentStatus,
      this.appointmentStatus,
      this.services,
      this.slots,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.id});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'] != null ? ShopModel.fromJson(json['shopId']) : null;
    memberId = json['memberId'] != null ? json['memberId'] : null;
    userId = json['userId'] != null ? UserModel.fromJson(json['userId']) : null;
    totalPrice = json['totalPrice'];
    totalTime = json['totalTime'];
    paymentStatus = json['paymentStatus'];
    appointmentStatus = json['appointmentStatus'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    slots = json['slots'] != null ? List<int>.from(json['slots']) : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (shopId != null) {
      data['shopId'] = shopId!.toJson();
    }
    data['memberId'] = memberId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['totalPrice'] = totalPrice;
    data['totalTime'] = totalTime;
    data['paymentStatus'] = paymentStatus;
    data['appointmentStatus'] = appointmentStatus;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['slots'] = slots;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
