import 'package:beamer/beamer.dart';
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
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeLocation extends BeamLocation<BeamState> {
  // @override
  // Widget builder(BuildContext context, Widget navigator) =>
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: navigator,
  //     );
  @override
  List<String> get pathPatterns => [
        RoutesName.splash,
        RoutesName.home,
        RoutesName.onboarding,
        RoutesName.login,
        RoutesName.signUp,
        RoutesName.verifyOTP,
        RoutesName.forgotPassword,
        RoutesName.loginNow,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey(RoutesName.splash),
        title: 'Welcome to $appName',
        child: BMSplashScreen(),
      ),
      if (state.pathPatternSegments.contains("home"))
        BeamPage(
          key: ValueKey(RoutesName.home),
          title: appName,
          child: BMDashboardScreen(),
        ),
      if (state.pathPatternSegments.contains("onboarding"))
        const BeamPage(
          key: ValueKey(RoutesName.onboarding),
          title: 'Welcome to $appName',
          child: BMWalkThroughScreen(),
        ),
      if (state.pathPatternSegments.contains("register"))
        const BeamPage(
          key: ValueKey(RoutesName.signUp),
          title: '$appName Sign Up',
          child: BMRegisterScreen(),
        ),
      if (state.pathPatternSegments.contains("verify-otp"))
        const BeamPage(
          key: ValueKey(RoutesName.verifyOTP),
          title: 'Verify OTP',
          child: BMVerifyOTPScreen(),
        ),
      if (state.pathPatternSegments.contains("login"))
        const BeamPage(
          key: ValueKey(RoutesName.login),
          title: '$appName Login',
          child: BMLoginScreen(),
        ),
      if (state.pathPatternSegments.contains("forgot-password"))
        const BeamPage(
          key: ValueKey(RoutesName.forgotPassword),
          title: 'Forgot Password',
          child: BMForgetPasswordScreen(),
        ),
      if (state.pathParameters.containsKey("login-now"))
        const BeamPage(
          key: ValueKey(RoutesName.loginNow),
          title: 'Login Now',
          child: BMLoginNowScreen(),
        ),
    ];
  }
}
