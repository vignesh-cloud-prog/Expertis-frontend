import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view/screens/user/home/user_home_screen.dart';
import 'package:expertis/view/screens/user/auth/forget_password_screen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
import 'package:expertis/view/screens/user/auth/user_login_screen.dart';
import 'package:expertis/view/screens/user/auth/user_registration_screen.dart';
import 'package:expertis/view/screens/app/splash_screen.dart';
import 'package:expertis/view/screens/user/auth/verify_otp_screen.dart';
import 'package:expertis/view/screens/app/walkthrough_screen.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:flutter/cupertino.dart';

class HomeLocation extends BeamLocation<BeamState> {
  // @override
  // Widget builder(BuildContext context, Widget navigator) =>
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: navigator,
  //     );
  @override
  List<String> get pathPatterns => [
        '',
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
        key: ValueKey("default_screen"),
        title: 'Welcome to $appName',
        child: BMWalkThroughScreen(),
      ),
      if (state.pathPatternSegments.contains('splash'))
        const BeamPage(
          key: ValueKey("SplashScreen"),
          title: 'Welcome to $appName',
          child: BMSplashScreen(),
        ),
      if (state.pathPatternSegments.contains("home"))
        BeamPage(
          key: const ValueKey(RoutesName.home),
          title: ' Welcome to $appName home',
          child: UserHomeScreen(),
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
      if (state.pathParameters.containsKey("login-now"))
        const BeamPage(
          key: ValueKey(RoutesName.loginNow),
          title: 'Login Now',
          child: BMLoginNowScreen(),
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
    ];
  }
}
