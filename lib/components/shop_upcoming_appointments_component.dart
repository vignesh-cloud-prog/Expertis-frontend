import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMAppointMentTabComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class ShopUpcomingAppointmentComponent extends StatefulWidget {
  const ShopUpcomingAppointmentComponent({Key? key}) : super(key: key);

  @override
  State<ShopUpcomingAppointmentComponent> createState() =>
      _ShopUpcomingAppointmentComponentState();
}

class _ShopUpcomingAppointmentComponentState
    extends State<ShopUpcomingAppointmentComponent> {
  List<String> tabList = ['CONFIRMED', 'PENDING'];
  int selectedTab = 0;

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabList.map((e) {
              int index = tabList.indexOf(e);
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: radius(32),
                  color: selectedTab == index
                      ? bmPrimaryColor
                      : Colors.transparent,
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  tabList[index],
                  style: boldTextStyle(
                    size: 14,
                    color: selectedTab == index
                        ? white
                        : appStore.isDarkModeOn
                            ? bmPrimaryColor
                            : bmSpecialColorDark,
                  ),
                ).onTap(() {
                  setState(() {
                    selectedTab = index;
                  });
                }),
              );
            }).toList(),
          ).center(),
          20.height,
          selectedTab == 0
              ? BMAppointMentTabComponent(tabOne: true)
              : BMAppointMentTabComponent(tabOne: false),
          20.height,
        ],
      ).paddingAll(16),
    );
  }
}
