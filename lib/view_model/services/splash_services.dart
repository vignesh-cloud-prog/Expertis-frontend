import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel.getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      print(value.token.toString());

      await Future.delayed(Duration(seconds: 3));
      if (value.token.toString() == 'null' || value.token.toString() == '') {
        context.beamToNamed(RoutesName.onboarding);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
