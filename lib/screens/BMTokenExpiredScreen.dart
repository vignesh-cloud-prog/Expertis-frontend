import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class BMTokenExpiredScreen extends StatefulWidget {
  const BMTokenExpiredScreen({Key? key}) : super(key: key);
  static const routeName = '/token-expired';
  @override
  State<BMTokenExpiredScreen> createState() => _BMTokenExpiredScreenState();
}

class _BMTokenExpiredScreenState extends State<BMTokenExpiredScreen> {
  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.logout();

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/session_expired.png', height: 200),
            Text('OOPs!',
                style: boldTextStyle(
                    color: appStore.isDarkModeOn
                        ? Colors.white
                        : bmSpecialColorDark,
                    size: 30)),
            16.height,
            Text(
              'Your session has expired. Please login again.',
              style: secondaryTextStyle(
                  color: appStore.isDarkModeOn
                      ? Colors.white
                      : bmSpecialColorDark),
              textAlign: TextAlign.center,
            ),
            16.height,
            AppButton(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child:
                  Text('Login Now', style: boldTextStyle(color: Colors.white)),
              padding: EdgeInsets.all(16),
              width: 150,
              color: bmPrimaryColor,
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesName.login);
              },
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
