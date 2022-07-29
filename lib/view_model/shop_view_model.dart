import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/services_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<ShopModel> selectedShop = ApiResponse.loading();
  ApiResponse<ServicesListModel> services = ApiResponse.loading();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSelectedShop(ApiResponse<ShopModel> response) {
    selectedShop = response;
    if (kDebugMode) {
      // print("response ${nearbyShopList.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchServicesDataApi(String shopId) async {
    print("shop id is $shopId");
    _myRepo.fetchServicesData(shopId).then((value) {
      // print("Selected shop data is \n ${value.toString()}");
      setServices(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedShop(ApiResponse.error(error.toString()));
    });
  }

  Future<void> sendShopData(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic?> files,
      BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('data: $data');
      print('files: $files');
    }
    _myRepo
        .uploadShopDataApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      String shopId = value["data"]["id"];
      ShopModel shop = ShopModel.fromJson(value["data"]);
      print("shop id is $shopId");
      print("shop is ${shop.toJson()}");
      setLoading(false);
      if (shop.shopName == null) {
        print("You need to give shop info");
        Beamer.of(context).beamToReplacementNamed(
            RoutesName.updateShopInfoWithId(shop.id),
            data: shop);
      } else if (shop.contact?.pinCode == null) {
        print("You need to give contact info");
        Beamer.of(context).beamToReplacementNamed(
            RoutesName.updateShopContactWithId(shop.id),
            data: shop);
      } else if (shop.services!.isEmpty) {
        Beamer.of(context)
            .beamToReplacementNamed(RoutesName.ownerDashboard, data: shop);
        print("You need to give services info");
      } else {
        Beamer.of(context)
            .beamToReplacementNamed(RoutesName.ownerDashboard, data: shop);
        print("You are good to go");
      }

      // Beamer.of(context)
      //     .beamToReplacementNamed(RoutesName.updateShopInfoWithId());
      Utils.flushBarErrorMessage('successfully', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  setServices(ApiResponse<ServicesListModel> response) {
    services = response;
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
