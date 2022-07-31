import 'package:expertis/components/BMAppointmentComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/appointment_list_model.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointMentTabComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class ShopAllAppointmentComponent extends StatefulWidget {
  final String? shopId;
  const ShopAllAppointmentComponent({Key? key, required this.shopId})
      : super(key: key);

  @override
  State<ShopAllAppointmentComponent> createState() =>
      _ShopAllAppointmentComponentState();
}

class _ShopAllAppointmentComponentState
    extends State<ShopAllAppointmentComponent> {
  List<String> tabList = [
    'CONFIRMED',
    'PENDING',
    'COMPLETED',
    'REJECTED',
    'CANCELLED'
  ];
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
                value.shop?.first ?? '', false)
          });
    } else {
      appointmentViewModel.getShopAppointmentsApi(widget.shopId ?? '', false);
    }
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
                  List<AppointmentModel>? appointments;
                  if (selectedTab == 1) {
                    appointments = value.pending.appointments;
                  } else if (selectedTab == 2) {
                    appointments = value.completed.appointments;
                  } else if (selectedTab == 3) {
                    appointments = value.rejected.appointments;
                  } else if (selectedTab == 4) {
                    appointments = value.cancelled.appointments;
                  } else {
                    appointments = value.upcoming.appointments;
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: appointments?.map((e) {
                          return BMAppointmentComponent(element: e);
                        }).toList() ??
                        [
                          Center(
                            child: Text('No upcoming appointments'),
                          ),
                        ],
                  );

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
