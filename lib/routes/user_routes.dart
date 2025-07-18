import 'package:beamer/beamer.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view/screens/user/auth/change_password_screen.dart';
import 'package:expertis/view/screens/user/home/user_home_screen.dart';
import 'package:expertis/view/screens/user/profile/user_profile_edit_screen.dart';
import 'package:expertis/view/screens/user/shop/view_all_shops_screen.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:flutter/cupertino.dart';

class UserLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        RoutesName.viewProfile,
        RoutesName.createProfile,
        RoutesName.editProfile,
        RoutesName.changePassword,
        RoutesName.adminUserEditProfile,
        RoutesName.viewAllShops
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey(RoutesName.viewProfile),
        title: 'Welcome to $appName',
        child: UserHomeScreen(),
      ),
      if (state.pathPatternSegments.contains("create-profile"))
        BeamPage(
          key: const ValueKey(RoutesName.createProfile),
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
          key: const ValueKey(RoutesName.adminUserEditProfile),
          title: 'Admin shop update Profile.',
          child: BMUserProfileEditScreen(
            isadmin: true,
            user: data as UserModel,
          ),
        ),
      if (state.pathPatternSegments.contains("user") &&
          state.pathPatternSegments.contains("edit-profile"))
        BeamPage(
          key: const ValueKey(RoutesName.editProfile),
          title: 'User Update Profile',
          child: BMUserProfileEditScreen(
            isadmin: false,
          ),
        ),
      if (state.pathPatternSegments.contains("shop") &&
          state.pathPatternSegments.contains("viewall"))
        const BeamPage(
          key: ValueKey(RoutesName.viewAllShops),
          title: 'viewall shops',
          child: ViewAllShopsScreen(),
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
