import 'package:expertis/models/appointment_model.dart';

class AppointmentListModel {
  List<AppointmentModel>? appointments;

  AppointmentListModel({this.appointments});

  AppointmentListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      print('data ${json['data']}');
      appointments = <AppointmentModel>[];
      json['data'].forEach((v) {
        print(v);
        appointments!.add(AppointmentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (appointments != null) {
      data['appointment'] = appointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isEmpty => appointments == null || appointments!.isEmpty;

  void addAppointment(AppointmentModel appointment) {
    if (appointments == null) {
      appointments = <AppointmentModel>[];
    }
    appointments!.add(appointment);
  }
}
