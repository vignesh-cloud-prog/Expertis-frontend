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
  String? message;

  UserModel(
      {this.email = "example.com",
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
      this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userPic = json['userPic'];
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
    data['verified'] = this.verified;
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toString()).toList();
    }
    if (this.appointments != null) {
      data['appointments'] =
          this.appointments!.map((v) => v.toString()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userPic'] = this.userPic;
    data['id'] = this.id;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
