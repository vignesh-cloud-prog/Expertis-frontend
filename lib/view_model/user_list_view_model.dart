import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
// import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/user_list_model.dart';
import 'package:expertis/respository/user_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UserListViewModel with ChangeNotifier {
  final _myRepo = UserRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

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

  Future<void> deleteUserApi(String? id, BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('id: $id');
    }

    _myRepo.deleteUser(id).then((value) {
      if (kDebugMode) {
        print(value);
      }
      userList.data?.users?.removeWhere((element) => element.id == id);
      setLoading(false);
      Utils.toastMessage(' successfully deleted');

      Beamer.of(context).beamToReplacementNamed(RoutesName.adminUsers);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }
}
