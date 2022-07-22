import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class SetAppointmentStatus extends StatefulWidget {
  final String appointmentId;
  final String status;
  const SetAppointmentStatus(
      {Key? key, required this.appointmentId, required this.status})
      : super(key: key);

  @override
  State<SetAppointmentStatus> createState() => _SetAppointmentStatusState();
}

class _SetAppointmentStatusState extends State<SetAppointmentStatus> {
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
            Image.asset('images/check.png', height: 200),
            Text('Congrats!',
                style: boldTextStyle(
                    color: appStore.isDarkModeOn
                        ? Colors.white
                        : bmSpecialColorDark,
                    size: 30)),
            16.height,
            Text(
              'You have successfully change password. Please use new password when logging in.',
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
                Beamer.of(context).beamToReplacementNamed(RoutesName.login);
              },
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
