import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ShopModel> selectedShop = ApiResponse.loading();

  setSelectedShop(ApiResponse<ShopModel> response) {
    selectedShop = response;
    if (kDebugMode) {
      // print("response ${nearbyShopList.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchSelectedShopDataApi(String shopId) async {
    print("shop id is $shopId");
    _myRepo.fetchSelectedShopData(shopId).then((value) {
      // print("Selected shop data is \n ${value.toString()}");
      setSelectedShop(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedShop(ApiResponse.error(error.toString()));
    });
  }
}
