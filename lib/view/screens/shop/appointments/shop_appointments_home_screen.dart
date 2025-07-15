import 'package:expertis/components/shop_all_appointments_component.dart';
import 'package:expertis/components/shop_upcoming_appointments_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../../../utils/BMColors.dart';

class ShopAppointmentsHomeScreen extends StatefulWidget {
  final String? shopId;
  const ShopAppointmentsHomeScreen({Key? key, required this.shopId})
      : super(key: key);

  @override
  State<ShopAppointmentsHomeScreen> createState() =>
      _ShopAppointmentsHomeScreenState();
}

class _ShopAppointmentsHomeScreenState
    extends State<ShopAppointmentsHomeScreen> {
  List<String> tabList = ['UPCOMING', 'ALL'];
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
    return Column(
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
                color:
                    selectedTab == index ? bmPrimaryColor : Colors.transparent,
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
        Divider(
          color: bmPrimaryColor,
          thickness: 1,
        ),
        selectedTab == 0
            ? ShopUpcomingAppointmentComponent(
                shopId: widget.shopId,
              )
            : ShopAllAppointmentComponent(
                shopId: widget.shopId,
              ),
        20.height,
      ],
    ).paddingAll(16);
  }
}
