import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMPortfolioComponent.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMChangePasswordScreen.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
import 'package:expertis/screens/BMRegisterScreen.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/screens/user_profile_edit_screen.dart';
import 'package:expertis/screens/BMVerifyOTPScreen.dart';
import 'package:expertis/screens/BMWalkThroughScreen.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:flutter/cupertino.dart';

class UserLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        RoutesName.viewProfile,
        RoutesName.createProfile,
        RoutesName.editProfile,
        RoutesName.changePassword,
        RoutesName.adminUserEditProfile
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey(RoutesName.viewProfile),
        title: 'Welcome to $appName',
        child: BMDashboardScreen(),
      ),
      if (state.pathPatternSegments.contains("create-profile"))
        BeamPage(
          key: ValueKey(RoutesName.createProfile),
          title: 'Create Profile',
          child: BMUserProfileEditScreen(
            title: 'Create Profile',
            isadmin: false,
            buttonName: 'Create',
          ),
        ),
      if (state.pathPatternSegments.contains("admin") &&
          state.pathPatternSegments.contains("update") &&
          state.pathPatternSegments.contains("user"))
        BeamPage(
          key: ValueKey(RoutesName.adminUserEditProfile),
          title: 'Admin shop update Profile',
          child: BMUserProfileEditScreen(
            isadmin: true,
            user: data as UserModel,
          ),
        ),
      if (state.pathPatternSegments.contains("user") &&
          state.pathPatternSegments.contains("edit-profile"))
        BeamPage(
          key: ValueKey(RoutesName.editProfile),
          title: 'User Update Profile',
          child: BMUserProfileEditScreen(
            isadmin: false,
          ),
        ),
      if (state.pathPatternSegments.contains("change-password"))
        const BeamPage(
          key: ValueKey(RoutesName.changePassword),
          title: 'Change Password',
          child: BMChangePasswordScreen(),
        ),
    ];
  }
}
