import 'package:expertis/data/response/status.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import 'BMWalkThroughScreen.dart';
import 'package:beamer/beamer.dart';

class BMSplashScreen extends StatefulWidget {
  const BMSplashScreen({Key? key}) : super(key: key);

  @override
  BMSplashScreenState createState() => BMSplashScreenState();
}

class BMSplashScreenState extends State<BMSplashScreen> {
  // SplashServices splashServices = SplashServices();
  AuthViewModel authViewModel = AuthViewModel();
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    // splashServices.checkAuthentication(context);
    authViewModel.verifyToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: ChangeNotifierProvider<AuthViewModel>(
        create: (BuildContext context) => authViewModel,
        child: Consumer<AuthViewModel>(builder: (context, value, _) {
          switch (value.verifyTokenResponse.status) {
            case Status.LOADING:
              return Column(
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
              ).center();
            case Status.ERROR:
              String error = value.verifyTokenResponse.message.toString();
              return Utils.findErrorPage(context, error);

            case Status.COMPLETED:
              context.beamToReplacementNamed(RoutesName.home);
              return const BMDashboardScreen(flag: false);
          }
          return Container();
        }),
      ),
    );
  }
}
