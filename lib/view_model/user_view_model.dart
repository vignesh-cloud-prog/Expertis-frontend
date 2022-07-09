import 'dart:convert';

import 'package:expertis/respository/user_repository.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:expertis/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final _myRepo = UserRepository();

  String email = "vignesh@xmail.com";
  String name = "Vignesh";
  String? phone;
  String? role;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
  String? createdAt;
  String? updatedAt;
  String userPic =
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.pixabay.com%2Fphoto%2F2015%2F10%2F05%2F22%2F37%2Fblank-profile-picture-973460_1280.png&imgrefurl=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&tbnid=H6pHpB03ZEAgeM&vet=12ahUKEwigm-bJnun4AhWm_zgGHfolDUAQMygBegUIARDZAQ..i&docid=wg0CyFWNfK7o5M&w=1280&h=1280&q=profile%20picture&ved=2ahUKEwigm-bJnun4AhWm_zgGHfolDUAQMygBegUIARDZAQ';
  String? id;
  String? token;
  String? message;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> saveToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString('token', token);
  }

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('user', json.encode(user.toJson()));
    final String? userJson = sp.getString('user');
    print("userJson: $userJson");
    notifyListeners();
    return true;
  }

  static Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userJson = sp.getString('user');
    print("userJson: $userJson");

    UserModel user = UserModel.fromJson(json.decode(userJson ?? '{}'));
    return user;
  }

  static Future<String> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? 'dummy';

    return token.toString();
  }

  static Future<String> getUserId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? id = sp.getString('id');

    return id.toString();
  }

  Future<bool> logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('user');
    notifyListeners();
    return true;
  }

  Future<void> updateUser(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, String> files,
      BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('data: $data');
      print('files: $files');
    }
    _myRepo
        .updateProfileApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Utils.flushBarErrorMessage('Profile updated successfully', context);
      Navigator.pushReplacementNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
