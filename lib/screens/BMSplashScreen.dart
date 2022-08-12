import 'package:expertis/data/response/status.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/user_home_screen.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import 'package:beamer/beamer.dart';

class BMSplashScreen extends StatefulWidget {
  const BMSplashScreen({Key? key}) : super(key: key);

  @override
  BMSplashScreenState createState() => BMSplashScreenState();
}

class BMSplashScreenState extends State<BMSplashScreen> {
  final userViewModel = UserViewModel();
  // SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    userViewModel.verifyToken();

    init();
  }

  Future<void> init() async {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    // splashServices.checkAuthentication(context);
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
      body: ChangeNotifierProvider<UserViewModel>.value(
        value: userViewModel,
        child: Consumer<UserViewModel>(builder: (context, value, _) {
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
              // Beamer.of(context).beamToReplacementNamed(RoutesName.home);
              return UserHomeScreen();
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
