import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/respository/appointment_repository.dart';
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

  setAppointmentStatus(ApiResponse<AppointmentModel> response) {
    selectedAppointment = response;
    if (kDebugMode) {
      // print("response ${nearbyShopList.toString()}");
    }
    notifyListeners();
  }

  Future<void> updateAppointmentStatusApi(
      String appointmentId, String status) async {
    print("appointment id is $appointmentId");
    print("status is $status");
    setAppointmentStatus(ApiResponse.loading());
    print("appointment id is $appointmentId");
    _myRepo.updateAppointmentStatus(appointmentId, status).then((value) {
      print("Updated appointment data is \n ${value.toString()}");
      setAppointmentStatus(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAppointmentStatus(ApiResponse.error(error.toString()));
    });
  }
}
