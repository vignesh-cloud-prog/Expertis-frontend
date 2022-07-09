class UserModel {
  late String email;
  late String name;
  String? phone;
  String? role;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
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
    this.email = "example.com",
    this.name = "Vignesh",
    this.phone,
    this.role,
    this.verified,
    this.shop,
    this.appointments,
    this.createdAt,
    this.updatedAt,
    this.userPic = 'images/face_two.jpg',
    this.id,
    this.token,
    this.address,
    this.dob,
    this.gender,
    this.pinCode,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'].toString();
    name = json['name'].toString();
    phone = json['phone'].toString();
    role = json['role'].toString();
    verified = json['verified'];
    if (json['shop'] != null) {
      shop = <String>[];
      json['shop'].forEach((v) {
        shop!.add(v.toString());
      });
    }
    if (json['appointments'] != null) {
      appointments = <String>[];
      json['appointments'].forEach((v) {
        appointments!.add(v.toString());
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
    pinCode = json['pinCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    data['verified'] = verified;
    if (shop != null) {
      data['shop'] = shop!.map((v) => v.toString()).toList();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toString()).toList();
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
