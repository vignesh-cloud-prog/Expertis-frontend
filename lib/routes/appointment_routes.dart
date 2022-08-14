import 'package:beamer/beamer.dart';
import 'package:expertis/components/set_appointment_status_component.dart';
import 'package:expertis/fragments/user_appointments_component.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view/screens/user/home/user_home_screen.dart';
import 'package:expertis/view/screens/user/auth/forget_password_screen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
import 'package:expertis/screens/appointment_detail_screen.dart';
import 'package:expertis/view/screens/user/appointment/book_appointment_screen.dart';
import 'package:expertis/view/screens/user/auth/user_login_screen.dart';
import 'package:expertis/view/screens/user/auth/user_registration_screen.dart';
import 'package:expertis/view/screens/app/splash_screen.dart';
import 'package:expertis/view/screens/user/auth/verify_otp_screen.dart';
import 'package:expertis/view/screens/app/walkthrough_screen.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:flutter/cupertino.dart';

class AppointmentLocation extends BeamLocation<BeamState> {
  // @override
  // Widget builder(BuildContext context, Widget navigator) =>
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: navigator,
  //     );
  @override
  List<String> get pathPatterns => [
        RoutesName.appointment,
        RoutesName.pastAppointment,
        RoutesName.upcomingAppointment,
        RoutesName.viewAppointment,
        RoutesName.setAppointmentStatus,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: const ValueKey(RoutesName.appointment),
          title: 'Appointment',
          child: UserHomeScreen(),
          type: BeamPageType.slideTransition),
      if (state.uri.pathSegments.contains('appointments') &&
          state.pathParameters.containsKey('past'))
        BeamPage(
          key: const ValueKey(RoutesName.pastAppointment),
          title: 'View old Appointments',
          child: UserAppointmentsComponent(
            tabNo: 1,
          ),
        ),
      if (state.uri.pathSegments.contains('appointments') &&
          state.pathParameters.containsKey('upcoming'))
        BeamPage(
          key: const ValueKey(RoutesName.upcomingAppointment),
          title: 'View Upcoming Appointments',
          child: UserAppointmentsComponent(
            tabNo: 0,
          ),
        ),
      if (state.uri.pathSegments.contains('view') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.viewAppointment),
          title: 'View Appointment ${state.pathParameters['appointmentId']}',
          child: ViewAppointmentScreen(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
          ),
        ),
      if (state.pathParameters.containsKey('status') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.setAppointmentStatus),
          title:
              '${state.pathParameters['status']} ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: state.pathParameters['status'] ?? '',
          ),
        ),
    ];
  }
}
