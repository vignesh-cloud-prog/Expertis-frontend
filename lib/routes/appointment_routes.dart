import 'package:beamer/beamer.dart';
import 'package:expertis/fragments/BMAppointmentFragment.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMForgetPasswordScreen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
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
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: ValueKey(RoutesName.appointment),
          title: 'Appointment',
          child: BMDashboardScreen(),
          type: BeamPageType.slideTransition),
    ];
  }
}
