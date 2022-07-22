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
        RoutesName.viewAppointment,
        RoutesName.cancelAppointment,
        RoutesName.rejectAppointment,
        RoutesName.acceptAppointment,
        RoutesName.confirmAppointment,
        RoutesName.completeAppointment,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: const ValueKey(RoutesName.appointment),
          title: 'Appointment',
          child: BMDashboardScreen(),
          type: BeamPageType.slideTransition),
      if (state.uri.pathSegments.contains('view') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.viewAppointment),
          title: 'View Appointment ${state.pathParameters['appointmentId']}',
          child: ViewAppointmentScreen(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
          ),
        ),
      if (state.uri.pathSegments.contains('cancel') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.cancelAppointment),
          title: 'cancel ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: 'cancelled',
          ),
        ),
      if (state.uri.pathSegments.contains('reject') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.rejectAppointment),
          title: 'reject ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: 'rejected',
          ),
        ),
      if (state.uri.pathSegments.contains('accept') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.acceptAppointment),
          title: 'accept ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: 'accepted',
          ),
        ),
      if (state.uri.pathSegments.contains('confirm') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.confirmAppointment),
          title: 'confirm ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: 'confirmed',
          ),
        ),
      if (state.uri.pathSegments.contains('complete') &&
          state.pathParameters.containsKey('appointmentId'))
        BeamPage(
          key: const ValueKey(RoutesName.completeAppointment),
          title: 'complete ${state.pathParameters['appointmentId']}',
          child: SetAppointmentStatus(
            appointmentId: state.pathParameters['appointmentId'] ?? 'null',
            status: 'completed',
          ),
        ),
    ];
  }
}
