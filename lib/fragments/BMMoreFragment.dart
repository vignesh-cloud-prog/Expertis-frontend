import 'package:expertis/models/user_model.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../screens/BMFavouritesScreen.dart';
import '../screens/BMShoppingScreen.dart';
import '../utils/BMBottomSheet.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'BMAppointmentFragment.dart';

class BMMoreFragment extends StatefulWidget {
  const BMMoreFragment({Key? key}) : super(key: key);

  @override
  State<BMMoreFragment> createState() => _BMMoreFragmentState();
}

class _BMMoreFragmentState extends State<BMMoreFragment> {
  late UserModel? user;
  @override
  void initState() {
    _getUserData();
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  _getUserData() async {
    user = await UserViewModel.getUser();
    if (kDebugMode) print("user: ${user.toString()}");
    setState(() {
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            upperContainer(
              screenContext: context,
              child: Column(
                children: [
                  16.height,
                  user == null
                      ? Image.asset('images/face_two.jpg',
                              height: 100, width: 100, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(100)
                      : Image.network(user!.userPic,
                              height: 100, width: 100, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(100),
                  8.height,
                  Text(user == null ? "Vignesh" : user!.name,
                      style: boldTextStyle(color: white, size: 20)),
                  Text(user == null ? 'example@gmail.com' : user!.email,
                      style: boldTextStyle(color: white))
                ],
              ),
            ),
            lowerContainer(
                child: Column(
                  children: [
                    16.height,
                    Row(
                      children: [
                        appStore.isDarkModeOn
                            ? Icon(Icons.brightness_2,
                                color: bmPrimaryColor, size: 30)
                            : Icon(Icons.wb_sunny_rounded,
                                color: bmPrimaryColor, size: 30),
                        16.width,
                        Text('Choose App Theme',
                                style: boldTextStyle(
                                    size: 20,
                                    color: appStore.isDarkModeOn
                                        ? white
                                        : bmSpecialColorDark))
                            .expand(),
                        Switch(
                          value: appStore.isDarkModeOn,
                          activeTrackColor: bmSpecialColor,
                          inactiveThumbColor: bmPrimaryColor,
                          inactiveTrackColor: Colors.grey,
                          onChanged: (val) async {
                            appStore.toggleDarkMode(value: val);
                            await setValue(isDarkModeOnPref, val);
                          },
                        ),
                      ],
                    )
                        .paddingOnly(left: 16, top: 8, right: 16, bottom: 8)
                        .onTap(() async {
                      if (getBoolAsync(isDarkModeOnPref)) {
                        appStore.toggleDarkMode(value: false);
                        await setValue(isDarkModeOnPref, false);
                      } else {
                        appStore.toggleDarkMode(value: true);
                        await setValue(isDarkModeOnPref, true);
                      }
                    }),
                    SettingItemWidget(
                      title: 'Check Appointments',
                      leading: Icon(Icons.calendar_today,
                          color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        BMAppointmentFragment().launch(context);
                      },
                    ),
                    SettingItemWidget(
                      title: 'Edit Profile',
                      leading:
                          Icon(Icons.edit, color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.editProfile);
                      },
                    ),
                    SettingItemWidget(
                      title: 'Favourites',
                      leading:
                          Icon(Icons.favorite, color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        BMFavouritesScreen().launch(context);
                      },
                    ),
                    SettingItemWidget(
                      title: 'Dashboard',
                      leading: Icon(Icons.dashboard,
                          color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        BMShoppingScreen(isOrders: true).launch(context);
                      },
                    ),
                    SettingItemWidget(
                      title: 'Contact Us',
                      leading:
                          Icon(Icons.call, color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        showSelectStaffBottomSheet(context);
                      },
                    ),
                    SettingItemWidget(
                      title: 'Logout',
                      leading: const Icon(Icons.logout_sharp,
                          color: bmPrimaryColor, size: 30),
                      titleTextStyle: boldTextStyle(
                          size: 20,
                          color: appStore.isDarkModeOn
                              ? white
                              : bmSpecialColorDark),
                      onTap: () {
                        userViewModel.logout().then((value) => {
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.onboarding)
                            });
                      },
                    )
                  ],
                ),
                screenContext: context),
          ],
        ),
      ),
    );
  }
}
