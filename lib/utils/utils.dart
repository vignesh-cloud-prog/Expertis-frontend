import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMNoInternetScreen.dart';
import 'package:expertis/screens/BMSomethingWentWrongScreen.dart';
import 'package:expertis/screens/BMTokenExpiredScreen.dart';
import 'package:expertis/screens/BMWalkThroughScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:beamer/beamer.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void focusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static Widget findErrorPage(BuildContext context, String error) {
    // print("error $error");
    if (error.contains("XMLHttpRequest")) {
      context.beamToReplacementNamed(RoutesName.noConnection);
      return const BMNoInternetScreen();
    } else if (error.contains("Authentication Failed")) {
      context.beamToReplacementNamed(RoutesName.tokenExpired);
      return const BMTokenExpiredScreen();
    } else if (error.contains("Token Not Found")) {
      context.beamToReplacementNamed(RoutesName.onboarding);
      return const BMWalkThroughScreen();
    } else {
      context.beamToNamed(RoutesName.unKnownError);
      return const BMErrorScreen();
    }
  }
}
