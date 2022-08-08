import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

class ShopListViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ShopListModel> shopList = ApiResponse.loading();
  ApiResponse<ShopListModel> nearbyShopList = ApiResponse.loading();

  setShopList(ApiResponse<ShopListModel> response) {
    shopList = response;
    // if (kDebugMode) {
    //   // print("response ${shopList.toString()}");
    // }
    notifyListeners();
  }

  setNearbyShopList(ApiResponse<ShopListModel> response) {
    nearbyShopList = response;
    // if (kDebugMode) {
    //   // print("response ${nearbyShopList.toString()}");
    // }
    notifyListeners();
  }

  Future<void> fetchShopsDataApi() async {
    _myRepo.fetchHomeData().then((value) {
      setShopList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setShopList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchNearbyShopsDataApi() async {
    _myRepo.fetchNearbyShopsData().then((value) {
      setNearbyShopList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNearbyShopList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> deleteShopApi(String? id, BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('id: $id');
    }

    _myRepo.deleteShop(id).then((value) {
      if (kDebugMode) {
        print(value);
      }
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Utils.toastMessage(' successfully deleted');
      // String shopId = value['data']['id'];
      // print("shopid is $shopId");
      shopList.data?.shops?.removeWhere((element) => element.id == id);

      Beamer.of(context).beamToReplacementNamed(RoutesName.adminShops);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }
}
