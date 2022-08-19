import 'package:beamer/beamer.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../screens/BMFavouritesScreen.dart';
import '../screens/BMShoppingScreen.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'user_appointments_component.dart';

class UserMoreComponent extends StatefulWidget {
  const UserMoreComponent({Key? key}) : super(key: key);

  @override
  State<UserMoreComponent> createState() => _UserMoreComponentState();
}

class _UserMoreComponentState extends State<UserMoreComponent> {
  UserModel? user;
  @override
  void initState() {
    UserViewModel.getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    print('role ${user?.roles!.toJson()}');
    // print("admin ${user!.roles!.isAdmin}");
    // print("owner ${user!.roles!.isShopOwner}");
    // print("member ${user!.roles!.isShopMember.toString() == "true"}");

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: user == null
          ? CircularProgressIndicator().center()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  upperContainer(
                    screenContext: context,
                    child: Column(
                      children: [
                        16.height,
                        user!.userPic == "" || user!.userPic == "null"
                            ? Image.network(Assets.defaultUserImage,
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
                          // Row(
                          //   children: [
                          //     appStore.isDarkModeOn
                          //         ? Icon(Icons.brightness_2,
                          //             color: bmPrimaryColor, size: 30)
                          //         : Icon(Icons.wb_sunny_rounded,
                          //             color: bmPrimaryColor, size: 30),
                          //     16.width,
                          //     Text('Choose App Theme',
                          //             style: boldTextStyle(
                          //                 size: 20,
                          //                 color: appStore.isDarkModeOn
                          //                     ? white
                          //                     : bmSpecialColorDark))
                          //         .expand(),
                          //     Switch(
                          //       value: appStore.isDarkModeOn,
                          //       activeTrackColor: bmSpecialColor,
                          //       inactiveThumbColor: bmPrimaryColor,
                          //       inactiveTrackColor: Colors.grey,
                          //       onChanged: (val) async {
                          //         appStore.toggleDarkMode(value: val);
                          //         await setValue(isDarkModeOnPref, val);
                          //       },
                          //     ),
                          //   ],
                          // )
                          //     .paddingOnly(
                          //         left: 16, top: 8, right: 16, bottom: 8)
                          //     .onTap(() async {
                          //   if (getBoolAsync(isDarkModeOnPref)) {
                          //     appStore.toggleDarkMode(value: false);
                          //     await setValue(isDarkModeOnPref, false);
                          //   } else {
                          //     appStore.toggleDarkMode(value: true);
                          //     await setValue(isDarkModeOnPref, true);
                          //   }
                          // }),

                          SettingItemWidget(
                            title: 'Edit Profile',
                            leading: Icon(Icons.edit,
                                color: bmPrimaryColor, size: 30),
                            titleTextStyle: boldTextStyle(
                                size: 20,
                                color: appStore.isDarkModeOn
                                    ? white
                                    : bmSpecialColorDark),
                            onTap: () {
                              Beamer.of(context)
                                  .beamToNamed(RoutesName.editProfile);
                            },
                          ),
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
                              Beamer.of(context)
                                  .beamToNamed(RoutesName.appointment);
                            },
                          ),
                          SettingItemWidget(
                            title: 'Favourites',
                            leading: Icon(Icons.favorite,
                                color: bmPrimaryColor, size: 30),
                            titleTextStyle: boldTextStyle(
                                size: 20,
                                color: appStore.isDarkModeOn
                                    ? white
                                    : bmSpecialColorDark),
                            onTap: () {
                              BMFavouritesScreen().launch(context);
                            },
                          ),
                          user!.roles?.isShopOwner == true
                              ? user!.shop?.isEmpty == false
                                  ? SettingItemWidget(
                                      title: 'Dashboard',
                                      leading: Icon(Icons.dashboard,
                                          color: bmPrimaryColor, size: 30),
                                      titleTextStyle: boldTextStyle(
                                          size: 20,
                                          color: appStore.isDarkModeOn
                                              ? white
                                              : bmSpecialColorDark),
                                      onTap: () {
                                        Beamer.of(context).beamToNamed(
                                            RoutesName.ownerDashboardWithId(
                                                user?.shop!.first.id));
                                      },
                                    )
                                  : SettingItemWidget(
                                      title: 'Create Shop',
                                      leading: Icon(Icons.add_business,
                                          color: bmPrimaryColor, size: 30),
                                      titleTextStyle: boldTextStyle(
                                          size: 20,
                                          color: appStore.isDarkModeOn
                                              ? white
                                              : bmSpecialColorDark),
                                      onTap: () {
                                        Beamer.of(context)
                                            .beamToNamed(RoutesName.createShop);
                                      },
                                    )
                              : Container(),
                          if (user!.roles!.isAdmin == true)
                            SettingItemWidget(
                              title: 'Admin Dashboard',
                              leading: Icon(Icons.add_home_work_outlined,
                                  color: bmPrimaryColor, size: 30),
                              titleTextStyle: boldTextStyle(
                                  size: 20,
                                  color: appStore.isDarkModeOn
                                      ? white
                                      : bmSpecialColorDark),
                              onTap: () {
                                Beamer.of(context)
                                    .beamToNamed(RoutesName.adminDashboard);
                              },
                            ),
                          SettingItemWidget(
                            title: 'Contact Us',
                            leading: Icon(Icons.call,
                                color: bmPrimaryColor, size: 30),
                            titleTextStyle: boldTextStyle(
                                size: 20,
                                color: appStore.isDarkModeOn
                                    ? white
                                    : bmSpecialColorDark),
                            onTap: () {
                              // showSelectStaffBottomSheet(context);
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
                                    Utils.toastMessage("Logout Successfully"),
                                  });
                              Beamer.of(context)
                                  .popToNamed(RoutesName.onboarding);
                              ;
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
