import 'package:beamer/beamer.dart';
import 'package:expertis/routes/appointment_routes.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/routes/more_routes.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/routes/search_routes.dart';

import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:expertis/screens/admin_dashboard_home.dart';
import 'package:expertis/screens/owner_dashboard_home_screen.dart';
import 'package:expertis/screens/services_home_screeen.dart';
import 'package:expertis/screens/shop_info_screen.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../fragments/BMAppointmentFragment.dart';
import '../fragments/BMHomeFragment.dart';
import '../fragments/BMMoreFragment.dart';
import '../main.dart';
import '../models/BMDashboardModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';

class ShopOwnerDashboardScreen extends StatefulWidget {
  bool flag = false;
  String? shopId;
  int tabNo;

  ShopOwnerDashboardScreen({
    super.key,
    required this.shopId,
    this.tabNo = 0,
  });

  @override
  ShopOwnerDashboardScreenState createState() =>
      ShopOwnerDashboardScreenState();
}

class ShopOwnerDashboardScreenState extends State<ShopOwnerDashboardScreen> {
  List<BMDashboardModel> list = getShopOwnerDashboardList();

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
    UserViewModel.getUser().then((value) => {
          setState(() {
            widget.shopId = value.shop!.first;
            print(value.shop?.first);
          })
        });
  }

  Widget getFragment() {
    if (selectedTab == 0) {
      return ShopDashBoardHomeScreen();
    } else if (selectedTab == 1) {
      return ServicesHomeScreen(shopId: widget.shopId);
    } else if (selectedTab == 2) {
      return const BMAppointmentFragment();
    } else if (selectedTab == 3) {
      return ShopInfoScreen();
    }
    return ShopDashBoardHomeScreen();
  }

  void getFragmentNo(selectedTab) {
    if (selectedTab == 0) {
      return Beamer.of(context).beamToNamed(RoutesName.ownerDashboardWithId(
        widget.shopId,
      ));
    } else if (selectedTab == 1) {
      return Beamer.of(context)
          .beamToNamed(RoutesName.shopServicesWithId(widget.shopId));
    } else if (selectedTab == 2) {
      return Beamer.of(context)
          .beamToNamed(RoutesName.shopAppointmentsWithId(widget.shopId));
    } else if (selectedTab == 3) {
      return Beamer.of(context)
          .beamToNamed(RoutesName.shopDetailsWithId(widget.shopId));
    } else {
      return Beamer.of(context).beamToNamed(RoutesName.ownerDashboard);
    }
  }

  // int getBeamLocation() {
  //   if (Beamer.of(context).currentBeamLocation.pathPatterns ==
  //       ["/shop/dashboard"]) {
  //     return 0;
  //   } else if (Beamer.of(context).currentBeamLocation.pathPatterns ==
  //       ["/shop/services"]) {
  //     return 1;
  //   } else if (Beamer.of(context).currentBeamLocation.pathPatterns ==
  //       ["/shop/appointment"]) {
  //     return 2;
  //   } else if (Beamer.of(context).currentBeamLocation is MoreLocation) {
  //     return 3;
  //   } else {
  //     return 0;
  //   }
  // }

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
