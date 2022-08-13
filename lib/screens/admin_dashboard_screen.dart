import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/admin_dashboard_home.dart';
import 'package:expertis/screens/admin_shops_screen.dart';
import 'package:expertis/screens/admin_tags_home_screen.dart';
import 'package:expertis/screens/admin_users_screen.dart';

import 'package:expertis/screens/services_home_screeen.dart';
import 'package:expertis/screens/shop_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../fragments/user_appointments_component.dart';
import '../fragments/user_home_component.dart';
import '../main.dart';
import '../models/BMDashboardModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';

class AdminDashBoardScreen extends StatefulWidget {
  bool flag = false;
  int tabNo;

  AdminDashBoardScreen({super.key, this.tabNo = 0});

  @override
  AdminDashBoardScreenState createState() => AdminDashBoardScreenState();
}

class AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  List<BMDashboardModel> list = getAdminDashboardList();

  int selectedTab = 0;
  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
    setState(() {
      selectedTab = widget.tabNo;
    });
  }

  Widget getFragment() {
    if (selectedTab == 0) {
      return AdminDashBoardHomeScreen();
    } else if (selectedTab == 1) {
      return AdminShopsHomeScreen();
    } else if (selectedTab == 2) {
      return AdminUsersHomeScreen();
    } else if (selectedTab == 3) {
      return AdminTagsHomeScreen();
    }
    return UserHomeComponent();
  }

  void getFragmentNo(selectedTab) {
    if (selectedTab == 0) {
      return Beamer.of(context).beamToNamed(RoutesName.adminDashboard);
    } else if (selectedTab == 1) {
      return Beamer.of(context).beamToNamed(RoutesName.adminShops);
    } else if (selectedTab == 2) {
      return Beamer.of(context).beamToNamed(RoutesName.adminUsers);
    } else if (selectedTab == 3) {
      return Beamer.of(context).beamToNamed(RoutesName.adminTags);
    } else {
      return Beamer.of(context).beamToNamed(RoutesName.adminDashboard);
    }
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
        return bmLightScaffoldBackgroundColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bmSpecialColor,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Beamer.of(context).beamToNamed(RoutesName.home);
            },
          ),
          10.width,
        ],
      ),
      backgroundColor: getDashboardColor(),
      body: SingleChildScrollView(child: getFragment()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            selectedTab = index;
          });
          getFragmentNo(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.cardColor,
        unselectedItemColor: bmPrimaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedTab,
        items: list.map((e) {
          return BottomNavigationBarItem(
            label: e.label,
            icon: Image.asset(e.unSelectedIcon,
                height: 24, color: bmPrimaryColor),
            activeIcon:
                Image.asset(e.selectedIcon, height: 24, color: bmPrimaryColor),
          );
        }).toList(),
      ).cornerRadiusWithClipRRectOnly(topLeft: 32, topRight: 32),
    );
  }
}
