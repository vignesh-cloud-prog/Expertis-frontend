import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class BMErrorScreen extends StatefulWidget {
  String message;
  BMErrorScreen({super.key, this.message = "Internal Error ocurred"});
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
              padding: const EdgeInsets.all(16),
              width: 150,
              color: bmPrimaryColor,
              onTap: () {
                Beamer.of(context).beamBack();
              },
              child: Text('Retry', style: boldTextStyle(color: Colors.white)),
            ),
            10.height,
            AppButton(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              padding: const EdgeInsets.all(16),
              width: 150,
              color: bmPrimaryColor,
              onTap: () {
                Beamer.of(context).beamToNamed(RoutesName.splash);
              },
              child: Text('Home', style: boldTextStyle(color: Colors.white)),
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
