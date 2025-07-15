import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class BMNoInternetScreen extends StatefulWidget {
  const BMNoInternetScreen({Key? key}) : super(key: key);
  static const routeName = '/no-internet';
  @override
  State<BMNoInternetScreen> createState() => _BMNoInternetScreenState();
}

class _BMNoInternetScreenState extends State<BMNoInternetScreen> {
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
            Image.asset('images/no-connection.png', height: 200),
            Text('OOPs!',
                style: boldTextStyle(
                    color: appStore.isDarkModeOn
                        ? Colors.white
                        : bmSpecialColorDark,
                    size: 30)),
            16.height,
            Text(
              'No internet connection. Please turn on your data.',
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
                setState(() {});
              },
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
