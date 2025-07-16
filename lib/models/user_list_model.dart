import 'package:expertis/models/user_model.dart';

class UserListModel {
  List<UserModel>? users;

  UserListModel({this.users});

  UserListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      users = <UserModel>[];
      json['data'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
