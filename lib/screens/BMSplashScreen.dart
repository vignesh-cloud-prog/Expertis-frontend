import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import 'BMWalkThroughScreen.dart';

class BMSplashScreen extends StatefulWidget {
  const BMSplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splash-view';

  @override
  BMSplashScreenState createState() => BMSplashScreenState();
}

class BMSplashScreenState extends State<BMSplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    splashServices.checkAuthentication(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.verifyToken(context);
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/beautymaster_logo.png", height: 200),
          Text('Beauty Master',
              style: boldTextStyle(
                  size: 20,
                  color: appStore.isDarkModeOn
                      ? Colors.white
                      : bmSpecialColorDark)),
        ],
      ).center(),
    );
  }
}
