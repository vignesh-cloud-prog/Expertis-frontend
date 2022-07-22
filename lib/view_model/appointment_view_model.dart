import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/respository/appointment_repository.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/foundation.dart';

class AppointmentViewModel with ChangeNotifier {
  final _myRepo = AppointmentRepository();

  ApiResponse<AppointmentModel> selectedAppointment = ApiResponse.loading();

  setSelectedAppointment(ApiResponse<AppointmentModel> response) {
    selectedAppointment = response;
    if (kDebugMode) {
      // print("response ${nearbyShopList.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchSelectedAppointment(String appointmentId) async {
    print("shop id is $appointmentId");
    _myRepo.fetchSelectedAppointment(appointmentId).then((value) {
      // print("Selected shop data is \n ${value.toString()}");
      setSelectedAppointment(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setSelectedAppointment(ApiResponse.error(error.toString()));
    });
  }
}
