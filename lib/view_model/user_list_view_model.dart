import 'package:expertis/data/response/api_response.dart';
// import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/user_list_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:expertis/respository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserListViewModel with ChangeNotifier {
  final _myRepo = UserRepository();

  ApiResponse<UserListModel> userList = ApiResponse.loading();

  getUserList(ApiResponse<UserListModel> response) {
    userList = response;
    // if (kDebugMode) {
    //   // print("response ${nearbyShopList.toString()}");
    // }
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    _myRepo.fetchUserData().then((value) {
      getUserList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      getUserList(ApiResponse.error(error.toString()));
    });
  }
}
