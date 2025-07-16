import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/respository/user_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:expertis/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final _myRepo = UserRepository();
  UserModel? user = UserModel();

  String email = "";
  String name = "";
  String? phone;
  String? role;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
  String? createdAt;
  String? updatedAt;
  String userPic = "";
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
    // print("userJson: $userJson");
    this.user = UserModel.fromJson(json.decode(userJson!));
    notifyListeners();
    return true;
  }

  static Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userJson = sp.getString('user');
    // print("userJson: $userJson");

    UserModel user = UserModel.fromJson(json.decode(userJson ?? '{}'));
    return user;
  }

  static Future<String> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? 'dummy';
    // print("token: $token");
    return token.toString();
  }

  static Future<String> getUserId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? id = sp.getString('id');

    return id.toString();
  }

  ApiResponse<dynamic> verifyTokenResponse = ApiResponse.loading();

  setVerifyTokenResponse(ApiResponse<dynamic> response) {
    verifyTokenResponse = response;
    notifyListeners();
  }

  Future<void> verifyToken() async {
    await Future.delayed(const Duration(seconds: 1));
    _myRepo.verifyTokenApi().then((value) {
      print("data $value");
      user = UserModel.fromJson(value["data"]);
      print(user?.toJson());
      setVerifyTokenResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // print("error ${error}");
      setVerifyTokenResponse(ApiResponse.error(error.toString()));
    });
  }

  Future<bool> logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('user');
    print('user logged out');
    // notifyListeners();
    return true;
  }

  Future<void> updateUser(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      bool isadmin,
      Map<String, String> files,
      BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      // print('data: $data');
      // print('files: $files');
    }
    _myRepo
        .updateProfileApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        // print(value.toString());
      }
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Utils.flushBarErrorMessage('Profile updated successfully', context);
      bool isShopOwner = value['data']['roles']["isShopOwner"];
      print('isShopOwner: $isShopOwner');
      List<dynamic> shop = value['data']["shop"];
      print('shop: $shop');
      print(shop.length);
      if (isShopOwner == true && shop.isEmpty) {
        print("You need to add a shop");
        Beamer.of(context).beamToNamed(RoutesName.createShop);
      } else if (isadmin) {
        Beamer.of(context).beamToReplacementNamed(RoutesName.adminDashboard);
      } else {
        Beamer.of(context).beamToReplacementNamed(RoutesName.more);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  //delete users

  Future<void> addOrRemoveFavApi(
      bool islike, String? shopId, BuildContext context) async {
    _myRepo.addOrRemoveFav(shopId, islike).then((value) {
      print(' data ${value['data']}');
      List<String> favShops = List<String>.from(value['data']['favlist']);
      print("$favShops favoriteShops");
      user!.favoriteShops = favShops;
      print('user.favoriteShops: ${user!.favoriteShops}');
      String? action;
      if (islike) {
        action = "Removed";
      } else {
        action = "Added";
      }
      Utils.toastMessage("$action Successfully");
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        // print(error.toString());
      }
    });
  }
}
