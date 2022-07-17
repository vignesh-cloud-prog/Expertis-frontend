import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class BMErrorScreen extends StatefulWidget {
  final String message;
  const BMErrorScreen({Key? key, this.message = "Internal Error ocurred"})
      : super(key: key);
  static const routeName = '/something-went-wrong';
  @override
  State<BMErrorScreen> createState() => _BMErrorScreenState();
}

class _BMErrorScreenState extends State<BMErrorScreen> {
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
                Beamer.of(context).beamBack();
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
                Beamer.of(context).beamToNamed(RoutesName.splash);
              },
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
