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
    shopId =
        json['shopId'] != null ? new ShopModel.fromJson(json['shopId']) : null;
    memberId = json['memberId'];
    userId =
        json['userId'] != null ? new UserModel.fromJson(json['userId']) : null;
    totalPrice = json['totalPrice'];
    totalTime = json['totalTime'];
    paymentStatus = json['paymentStatus'];
    appointmentStatus = json['appointmentStatus'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    slots = json['slots'].cast<int>();
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopId != null) {
      data['shopId'] = this.shopId!.toJson();
    }
    data['memberId'] = this.memberId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    data['totalTime'] = this.totalTime;
    data['paymentStatus'] = this.paymentStatus;
    data['appointmentStatus'] = this.appointmentStatus;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['slots'] = this.slots;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
