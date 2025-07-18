import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../view/screens/app/welcome_screen.dart';

class BMEnableNotificationScreen extends StatelessWidget {
  const BMEnableNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          20.height,
          Column(
            children: [
              Image.asset('images/notification.png', height: 200),
              Text('Get notified about new deals, messages, people and more.',
                  style: boldTextStyle(
                      color: appStore.isDarkModeOn
                          ? Colors.white
                          : bmSpecialColorDark),
                  textAlign: TextAlign.center),
              16.height,
              Text(
                'Turn on push notifications to help you don\'t missing anything awesome.',
                style: secondaryTextStyle(
                    color: appStore.isDarkModeOn
                        ? Colors.white
                        : bmSpecialColorDark),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              AppButton(
                width: context.width() - 40,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                padding: const EdgeInsets.all(16),
                color: bmPrimaryColor,
                onTap: () {
                  const BMWelcomeScreen().launch(context);
                },
                child: Text('Enable Notification',
                    style: boldTextStyle(color: Colors.white)),
              ),
              20.height,
              Text('Maybe Later',
                  style: boldTextStyle(
                      color: appStore.isDarkModeOn
                          ? bmPrimaryColor
                          : Colors.grey)),
            ],
          )
        ],
      ).paddingAll(20),
    );
  }
}
