import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class BMSomethingWentWrongScreen extends StatefulWidget {
  String message;
  BMSomethingWentWrongScreen(
      {Key? key, this.message = "Internal Error occured"})
      : super(key: key);
  static const routeName = '/something-went-wrong';
  @override
  State<BMSomethingWentWrongScreen> createState() =>
      _BMSomethingWentWrongScreenState();
}

class _BMSomethingWentWrongScreenState
    extends State<BMSomethingWentWrongScreen> {
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
            Image.asset('images/something_went_wrong.webp', height: 200),
            Text('Something Went Wrong!!',
                style: boldTextStyle(
                    color: appStore.isDarkModeOn
                        ? Colors.white
                        : bmSpecialColorDark,
                    size: 30)),
            16.height,
            Text(
              widget.message,
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
              child: Text('Retry', style: boldTextStyle(color: Colors.white)),
              padding: EdgeInsets.all(16),
              width: 150,
              color: bmPrimaryColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            10.height,
            AppButton(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Text('Home', style: boldTextStyle(color: Colors.white)),
              padding: EdgeInsets.all(16),
              width: 150,
              color: bmPrimaryColor,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.splash);
              },
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
