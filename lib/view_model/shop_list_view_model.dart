import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopListViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

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
}
