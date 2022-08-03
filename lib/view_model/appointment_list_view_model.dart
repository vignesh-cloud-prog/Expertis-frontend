import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/appointment_list_model.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/respository/appointment_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppointmentListViewModel with ChangeNotifier {
  final _myRepo = AppointmentRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  AppointmentModel appointmentModel = AppointmentModel();

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

  ApiResponse<AppointmentListModel> appointments = ApiResponse.loading();

  setUserAppointments(ApiResponse<AppointmentListModel> response) {
    appointments = response;
    if (kDebugMode) {
      print("response ${appointments.toString()}");
    }
    notifyListeners();
  }

  Future<void> getUserAppointmentsApi(String userId, bool past) async {
    setUserAppointments(ApiResponse.loading());
    _myRepo.fetchUserAppointments(userId, past).then((value) {
      setUserAppointments(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserAppointments(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<AppointmentListModel> shopAppointments = ApiResponse.loading();

  AppointmentListModel upcoming = AppointmentListModel();
  AppointmentListModel pending = AppointmentListModel();
  AppointmentListModel completed = AppointmentListModel();
  AppointmentListModel rejected = AppointmentListModel();
  AppointmentListModel cancelled = AppointmentListModel();

  setShopAppointments(ApiResponse<AppointmentListModel> response) {
    shopAppointments = response;
    if (kDebugMode) {
      print("response of shop appointments ${shopAppointments.data?.toJson()}");
    }
    shopAppointments.data!.appointments!.forEach((e) {
      print("e ${e.appointmentStatus}");
      if (e.appointmentStatus?.toLowerCase() == "accepted") {
        upcoming.addAppointment(e);
      } else if (e.appointmentStatus?.toLowerCase() == "pending") {
        pending.addAppointment(e);
      } else if (e.appointmentStatus?.toLowerCase() == "completed") {
        completed.addAppointment(e);
      } else if (e.appointmentStatus?.toLowerCase() == "rejected") {
        rejected.addAppointment(e);
      } else if (e.appointmentStatus?.toLowerCase() == "cancelled") {
        cancelled.addAppointment(e);
      }
    });
    if (kDebugMode) {
      print("upcoming ${upcoming.toJson()}");
      print("pending ${pending.toJson()}");
      print("completed ${completed.toJson()}");
      print("rejected ${rejected.toJson()}");
      print("cancelled ${cancelled.toJson()}");
    }
    notifyListeners();
  }

  Future<void> getShopAppointmentsApi(String shopId, bool upcoming) async {
    _myRepo.fetchShopAppointments(shopId, upcoming).then((value) {
      setShopAppointments(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setShopAppointments(ApiResponse.error(error.toString()));
    });
  }
}
