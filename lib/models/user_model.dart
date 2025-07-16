import 'package:expertis/models/shop_model.dart';

class UserModel {
  late String email;
  late String name;
  String? phone;
  Roles? roles;
  bool? verified;
  List<ShopModel>? shop;
  List<String>? appointments;
  List<String>? favoriteShops;
  String? createdAt;
  String? updatedAt;
  late String userPic;
  String? id;
  String? token;
  String? address;
  String? dob;
  String? gender;
  String? pinCode;

  UserModel({
    this.email = "",
    this.name = "",
    this.phone,
    this.roles,
    this.verified,
    this.shop,
    this.appointments,
    this.createdAt,
    this.updatedAt,
    this.userPic = '',
    this.id,
    this.token,
    this.address,
    this.dob,
    this.gender,
    this.pinCode,
    this.favoriteShops,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'].toString();
    name = json['name'].toString();
    phone = json['phone'].toString();
    roles = json['roles'] != null ? Roles.fromJson(json['roles']) : null;
    verified = json['verified'];
    if (json['shop'] != null) {
      shop = <ShopModel>[];
      json['shop']?.forEach((v) {
        shop!.add(ShopModel.fromJson(v));
      });
    }
    if (json['appointments'] != null) {
      appointments = <String>[];
      json['appointments'].forEach((v) {
        appointments!.add(v.toString());
      });
    }
    if (json['favoriteShops'] != null) {
      favoriteShops = <String>[];
      json['favoriteShops'].forEach((v) {
        favoriteShops!.add(v.toString());
      });
    }
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    userPic = json['userPic'].toString();
    id = json['id'].toString();
    token = json['token'].toString();
    address = json['address'].toString();
    dob = json['dob'].toString();
    gender = json['gender'].toString();
    pinCode =
        json['pinCode'].toString() == "null" ? "" : json['pinCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    if (roles != null) {
      data['roles'] = roles!.toJson();
    }
    data['verified'] = verified;
    if (shop != null) {
      data['shop'] = shop!.map((v) => v.toJson()).toList();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toString()).toList();
    }
    if (favoriteShops != null) {
      data['favoriteShops'] = favoriteShops!.map((v) => v.toString()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userPic'] = userPic;
    data['id'] = id;
    data['token'] = token;
    data['address'] = address;
    data['dob'] = dob;
    data['gender'] = gender;
    data['pinCode'] = pinCode;
    return data;
  }
}

class Roles {
  bool? isAdmin;
  bool? isUser;
  bool? isShopOwner;
  bool? isShopMember;
  String? id;

  Roles(
      {this.isAdmin,
      this.isUser,
      this.isShopOwner,
      this.isShopMember,
      this.id});

  Roles.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    isUser = json['isUser'];
    isShopOwner = json['isShopOwner'];
    isShopMember = json['isShopMember'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAdmin'] = isAdmin;
    data['isUser'] = isUser;
    data['isShopOwner'] = isShopOwner;
    data['isShopMember'] = isShopMember;
    data['id'] = id;
    return data;
  }
}
