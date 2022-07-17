import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ShopListModel> shopList = ApiResponse.loading();
  ApiResponse<ShopListModel> nearbyShopList = ApiResponse.loading();
  ApiResponse<ShopModel> selectedShop = ApiResponse.loading();

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

  setSelectedShop(ApiResponse<ShopModel> response) {
    selectedShop = response;
    if (kDebugMode) {
      // print("response ${nearbyShopList.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchShopsDataApi() async {
    setShopList(ApiResponse.loading());

    _myRepo.fetchHomeData().then((value) {
      setShopList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setShopList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchNearbyShopsDataApi() async {
    setNearbyShopList(ApiResponse.loading());

    _myRepo.fetchNearbyShopsData().then((value) {
      setNearbyShopList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setNearbyShopList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchSelectedShopDataApi(String shopId) async {
    setSelectedShop(ApiResponse.loading());
    print("shop id is $shopId");
    _myRepo.fetchSelectedShopData(shopId).then((value) {
      // print("Selected shop data is \n ${value.toString()}");
      setSelectedShop(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedShop(ApiResponse.error(error.toString()));
    });
  }
}
