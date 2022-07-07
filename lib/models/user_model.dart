class UserModel {
  String? email;
  String? name;
  String? phone;
  List<String>? role;
  String? date;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? token;
  String? message;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.role,
    this.date,
    this.verified,
    this.shop,
    this.appointments,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'].cast<String>();
    date = json['date'];
    verified = json['verified'];
    shop = json['shop'].cast<String>();
    appointments = json['appointments'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['date'] = this.date;
    data['verified'] = this.verified;
    data['shop'] = this.shop;
    data['appointments'] = this.appointments;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
