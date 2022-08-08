import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/services_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

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

  Future<void> fetchServicesDataApi(String? shopId) async {
    print("shop id is $shopId");
    _myRepo.fetchServicesData(shopId).then((value) {
      print("Services data is \n ${value.toString()}");
      setServices(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedShop(ApiResponse.error(error.toString()));
    });
  }

  Future<void> sendShopData(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      bool isadmin,
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
      UserViewModel.getUser().then((value) {
        UserModel user = value;
        user.shop = [shop];
        Provider.of<UserViewModel>(context, listen: false).user = user;
        UserViewModel().saveUser(user);
      });
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
        Beamer.of(context).beamToReplacementNamed(
            RoutesName.shopServicesWithId(shop.id),
            data: shop);
        print("You need to add services info");
      } else if (isadmin) {
        Beamer.of(context)
            .beamToReplacementNamed(RoutesName.adminShops, data: shop);
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

  Future<void> fetchSelectedShopDataApi(String shopId, {bool id = true}) async {
    print("shop id is $shopId");
    _myRepo.fetchSelectedShopData(shopId, id: id).then((value) {
      // print("Selected shop data is \n ${value.toString()}");
      setSelectedShop(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedShop(ApiResponse.error(error.toString()));
    });
  }

  Future<void> sendServiceData(
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
        .uploadServiceDataApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }

      setLoading(false);
      Beamer.of(context)
          .beamToReplacementNamed(RoutesName.shopServicesWithId(null));
      Utils.flushBarErrorMessage('successfully', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  Future<void> deleteServiceApi(String? id, BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('id: $id');
    }

    _myRepo.deleteService(id).then((value) {
      if (kDebugMode) {
        print(value);
      }
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Utils.toastMessage(' successfully deleted');
      String shopId = value['data']['id'];
      print("shopid is $shopId");
      Provider.of<ShopViewModel>(context, listen: false)
          .services
          .data
          ?.services
          ?.removeWhere((element) => element.id == id);

      Beamer.of(context)
          .beamToReplacementNamed(RoutesName.shopServicesWithId(shopId));
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
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
      Provider.of<ShopListViewModel>(context, listen: false)
          .shopList
          .data
          ?.shops
          ?.removeWhere((element) => element.id == id);

      Beamer.of(context).beamToReplacementNamed(RoutesName.adminShops);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  List slots = [];
  Future<void> fetchSlotsApi(
      String? shopId, String? memberId, String date) async {
    setLoading(true);
    _myRepo.fetchSlots(shopId, memberId, date).then((value) {
      setSlots(value);
      print("slots in view model is ${slots.toString()}");

      setLoading(false);
    }).onError((error, stackTrace) {
      print(error);
      Utils.toastMessage(error.toString());
    });
  }

  setSlots(List<dynamic> response) {
    print("response ${response}");
    slots = response.isEmpty ? [] : response.map((e) => e as int).toList();

    print('slots are $slots');
    notifyListeners();
  }
}
