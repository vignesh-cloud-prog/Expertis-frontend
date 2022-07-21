import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/respository/appointment_repository.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppointmentViewModel with ChangeNotifier {
  final _myRepo = AppointmentRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  AppointmentModel appointmentModel = AppointmentModel();
  ApiResponse<dynamic> getSlots = ApiResponse.loading();
  List<int> slots = [];
  Future<void> fetchSlotsApi(
      String? shopId, String? memberId, String date) async {
    _myRepo.fetchSlots(shopId, memberId, date).then((value) {
      setSlots(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  setSlots(ApiResponse<dynamic> response) {
    if (kDebugMode) {
      print("response ${response.data}");
    }
    slots = response.data;
    notifyListeners();
  }

  Future<void> BookAppointment(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.bookAppointment(data).then((value) {
      setLoading(false);
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // userViewModel.saveUser(UserModel.fromJson(value['data']));
      // userViewModel.saveToken(value['data']['token']);
      Beamer.of(context).beamToNamed(RoutesName.appointment);
      Utils.toastMessage("Appointment Booked Successfully");
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

  // ApiResponse<ShopListModel> shopList = ApiResponse.loading();
  // ApiResponse<AppointmentModel> selectedShop = ApiResponse.loading();

  // setShopList(ApiResponse<ShopListModel> response) {
  //   shopList = response;
  //   // if (kDebugMode) {
  //   //   // print("response ${shopList.toString()}");
  //   // }
  //   notifyListeners();
  // }

  // setSelectedShop(ApiResponse<AppointmentModel> response) {
  //   selectedShop = response;
  //   if (kDebugMode) {
  //     // print("response ${nearbyShopList.toString()}");
  //   }
  //   notifyListeners();
  // }

  // Future<void> fetchShopsDataApi() async {
  //   _myRepo.fetchHomeData().then((value) {
  //     setShopList(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     setShopList(ApiResponse.error(error.toString()));
  //   });
  // }

  // Future<void> fetchSelectedShopDataApi(String shopId) async {
  //   print("shop id is $shopId");
  //   _myRepo.fetchSelectedShopData(shopId).then((value) {
  //     // print("Selected shop data is \n ${value.toString()}");
  //     setSelectedShop(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     setSelectedShop(ApiResponse.error(error.toString()));
  //   });
  // }

