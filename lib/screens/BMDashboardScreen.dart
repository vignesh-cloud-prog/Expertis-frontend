import 'package:beamer/beamer.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/routes/appointment_routes.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/routes/more_routes.dart';
import 'package:expertis/routes/search_routes.dart';
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
  bool flag = false;

  BMDashboardScreen({super.key});

  @override
  BMDashboardScreenState createState() => BMDashboardScreenState();
}

class BMDashboardScreenState extends State<BMDashboardScreen> {
  List<BMDashboardModel> list = getDashboardList();

  int selectedTab = 0;

  Widget getFragment() {
    if (selectedTab == 0) {
      return BMHomeFragment();
    } else if (selectedTab == 1) {
      return PurchaseMoreScreen();
    } else if (selectedTab == 2) {
      return BMAppointmentFragment();
    } else {
      return const BMMoreFragment();
    }
  }

  void getFragmentNo(selectedTab) {
    if (selectedTab == 0) {
      return Beamer.of(context).beamToNamed("/home");
    } else if (selectedTab == 1) {
      return Beamer.of(context).beamToNamed("/search");
    } else if (selectedTab == 2) {
      return Beamer.of(context).beamToNamed("/appointment");
    } else {
      return Beamer.of(context).beamToNamed("/more");
    }
  }

  int getBeamLocation() {
    if (Beamer.of(context).currentBeamLocation is HomeLocation) {
      return 0;
    } else if (Beamer.of(context).currentBeamLocation is SearchLocation) {
      return 1;
    } else if (Beamer.of(context).currentBeamLocation is AppointmentLocation) {
      return 2;
    } else if (Beamer.of(context).currentBeamLocation is MoreLocation) {
      return 3;
    } else {
      return 0;
    }
  }

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
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
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserViewModel.getUser().then((value) {
      setState(() {
        userViewModel.user = value;
      });
    });
    selectedTab = getBeamLocation();
    return Scaffold(
      backgroundColor: getDashboardColor(),
      body: getFragment(),
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
