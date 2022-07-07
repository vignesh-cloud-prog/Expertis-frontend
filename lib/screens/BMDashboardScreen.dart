import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/screens/BMTokenExpiredScreen.dart';

import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../fragments/BMAppointmentFragment.dart';
import '../fragments/BMChatFragment.dart';
import '../fragments/BMHomeFragment.dart';
import '../fragments/BMMoreFragment.dart';
import '../main.dart';
import '../models/BMDashboardModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';

class BMDashboardScreen extends StatefulWidget {
  final bool flag;
  static const routeName = '/';

  BMDashboardScreen({required this.flag});

  @override
  _BMDashboardScreenState createState() => _BMDashboardScreenState();
}

class _BMDashboardScreenState extends State<BMDashboardScreen> {
  List<BMDashboardModel> list = getDashboardList();
  bool tokenValid = true;
  // authViewModel.verifyToken(header, context);

  int selectedTab = 0;

  Widget getFragment() {
    if (selectedTab == 0) {
      return BMHomeFragment();
    } else if (selectedTab == 1) {
      return PurchaseMoreScreen();
    } else if (selectedTab == 2) {
      return BMAppointmentFragment();
    } else if (selectedTab == 3) {
      return BMChatFragment();
    } else {
      return BMMoreFragment();
    }
  }

  _asyncValidateToken() async {
    final AuthRepository authRepository = AuthRepository();
    String token = await UserViewModel.getUserToken();
    Map<String, String> header = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    bool isValidToken = await authRepository.verifyTokenApi(header);

    setState(() {
      tokenValid = isValidToken;
    });
  }

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
    _asyncValidateToken();
  }

  @override
  void dispose() {
    if (widget.flag) {
      setStatusBarColor(appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor);
    } else {
      setStatusBarColor(Colors.transparent);
    }

    super.dispose();
  }

  Color getDashboardColor() {
    if (!appStore.isDarkModeOn) {
      if (selectedTab == 1 || selectedTab == 2 || selectedTab == 3) {
        return bmSecondBackgroundColorLight;
      } else {
        return bmLightScaffoldBackgroundColor;
      }
    } else {
      if (selectedTab == 1 || selectedTab == 2 || selectedTab == 3) {
        return bmSecondBackgroundColorDark;
      } else {
        return appStore.scaffoldBackground!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return !tokenValid
        ? const BMTokenExpiredScreen()
        : Scaffold(
            backgroundColor: getDashboardColor(),
            body: getFragment(),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedTab = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: context.cardColor,
              unselectedItemColor: bmPrimaryColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: selectedTab,
              items: list.map((e) {
                return BottomNavigationBarItem(
                  icon: Image.asset(e.unSelectedIcon,
                      height: 24, color: bmPrimaryColor),
                  activeIcon: Image.asset(e.selectedIcon,
                      height: 24, color: bmPrimaryColor),
                  label: '',
                );
              }).toList(),
            ).cornerRadiusWithClipRRectOnly(topLeft: 32, topRight: 32),
          );
  }
}
