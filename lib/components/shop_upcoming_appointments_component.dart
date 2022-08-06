import 'package:expertis/components/BMAppointmentComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointMentTabComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class ShopUpcomingAppointmentComponent extends StatefulWidget {
  final String? shopId;
  const ShopUpcomingAppointmentComponent({Key? key, required this.shopId})
      : super(key: key);

  @override
  State<ShopUpcomingAppointmentComponent> createState() =>
      _ShopUpcomingAppointmentComponentState();
}

class _ShopUpcomingAppointmentComponentState
    extends State<ShopUpcomingAppointmentComponent> {
  List<String> tabList = ['CONFIRMED', 'PENDING'];
  int selectedTab = 0;
  AppointmentListViewModel appointmentViewModel = AppointmentListViewModel();

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
    if (widget.shopId == null) {
      UserViewModel.getUser().then((value) => {
            appointmentViewModel.getShopAppointmentsApi(
                value.shop?.first.id ?? '', true)
          });
    } else {
      appointmentViewModel.getShopAppointmentsApi(widget.shopId ?? '', true);
    }
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appStore.isDarkModeOn
              ? bmSecondBackgroundColorDark
              : bmSecondBackgroundColorLight,
          borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: tabList.map((e) {
              int index = tabList.indexOf(e);
              return Container(
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
                    size: 12,
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
          // selectedTab == 0
          //     ? BMAppointMentTabComponent(tabOne: true)
          //     : BMAppointMentTabComponent(tabOne: false),
          // 20.height,
          ChangeNotifierProvider<AppointmentListViewModel>.value(
            value: appointmentViewModel,
            child: Consumer<AppointmentListViewModel>(
                builder: (context, value, _) {
              switch (value.shopAppointments.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                    child: Text(value.shopAppointments.message.toString()),
                  );
                case Status.COMPLETED:
                  return Container(
                      child: selectedTab == 0
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: value.upcoming.appointments?.map((e) {
                                    return BMAppointmentComponent(element: e);
                                  }).toList() ??
                                  [
                                    Center(
                                      child: Text('No upcoming appointments'),
                                    ),
                                  ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: value.pending.appointments?.map((e) {
                                    return BMAppointmentComponent(element: e);
                                  }).toList() ??
                                  [
                                    Center(
                                      child: Text('No pending appointments'),
                                    ),
                                  ],
                            ));

                default:
                  return Container();
              }
            }),
            // );
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     titleText(title: 'Today, ${getCurrentDate()}'),
            //     16.height,
            //     // Column(
            //     //   mainAxisSize: MainAxisSize.min,
            //     //   children: getAppointments().map((e) {
            //     //     return BMAppointmentComponent(element: e);
            //     //   }).toList(),
            //     // ),
            //     // 20.height,
            //     // titleText(
            //     //     title: widget.tabOne
            //     //         ? getTomorrowDate()
            //     //         : 'Yesterday, ${getYesterdayDate()}'),
            //     // 20.height,
            //     Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: getMoreAppointmentsList().map((e) {
            //         return BMAppointmentComponent(element: e);
            //       }).toList(),
            //     )
            //   ],
          ),
        ],
      ).paddingAll(16),
    );
  }
}
