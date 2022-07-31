import 'package:beamer/beamer.dart';
import 'package:expertis/components/set_appointment_status_component.dart';
import 'package:expertis/fragments/BMAppointmentFragment.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMForgetPasswordScreen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
import 'package:expertis/screens/appointment_detail_screen.dart';
import 'package:expertis/screens/book_appointment_screen.dart';
import 'package:expertis/screens/login_screen.dart';
import 'package:expertis/screens/BMRegisterScreen.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/screens/BMVerifyOTPScreen.dart';
import 'package:expertis/screens/BMWalkThroughScreen.dart';
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
          child: BMDashboardScreen(),
          type: BeamPageType.slideTransition),
      if (state.uri.pathSegments.contains('appointments') &&
          state.pathParameters.containsKey('past'))
        BeamPage(
          key: const ValueKey(RoutesName.pastAppointment),
          title: 'View old Appointments',
          child: BMAppointmentFragment(
            tabNo: 1,
          ),
        ),
      if (state.uri.pathSegments.contains('appointments') &&
          state.pathParameters.containsKey('upcoming'))
        BeamPage(
          key: const ValueKey(RoutesName.upcomingAppointment),
          title: 'View Upcoming Appointments',
          child: BMAppointmentFragment(
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
