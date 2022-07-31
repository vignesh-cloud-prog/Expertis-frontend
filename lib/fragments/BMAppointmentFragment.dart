import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMAppointmentComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointMentTabComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMAppointmentFragment extends StatefulWidget {
  int tabNo = 0;
  BMAppointmentFragment({Key? key, this.tabNo = 0}) : super(key: key);

  @override
  State<BMAppointmentFragment> createState() => _BMAppointmentFragmentState();
}

class _BMAppointmentFragmentState extends State<BMAppointmentFragment> {
  AppointmentListViewModel appointmentViewModel = AppointmentListViewModel();
  List<String> tabList = ['UPCOMING', 'PAST'];
  int selectedTab = 0;
  String userId = '';

  @override
  void initState() {
    UserViewModel.getUser().then((value) => {
          selectedTab = widget.tabNo,
          userId = value.id ?? '',
          print("widget.tabno: ${widget.tabNo}"),
          appointmentViewModel.getUserAppointmentsApi(
              value.id ?? '', widget.tabNo == 1 ? true : false)
        });
    print("Called api");
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
    print("build called");
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        elevation: 0,
        leading: SizedBox(),
        leadingWidth: 16,
        title: titleText(title: 'Appointments'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: appStore.isDarkModeOn
                ? bmSecondBackgroundColorDark
                : bmSecondBackgroundColorLight,
            borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Row(
                mainAxisSize: MainAxisSize.min,
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
                      if (index == 1) {
                        appointmentViewModel.getUserAppointmentsApi(
                            userId, true);
                      } else {
                        appointmentViewModel.getUserAppointmentsApi(
                            userId, false);
                      }
                    }),
                  );
                }).toList(),
              ).center(),
              ChangeNotifierProvider<AppointmentListViewModel>(
                create: (BuildContext context) => appointmentViewModel,
                child: Consumer<AppointmentListViewModel>(
                    builder: (context, value, _) {
                  switch (value.appointments.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                        child: Text(value.appointments.message.toString()),
                      );
                    case Status.COMPLETED:
                      List<AppointmentModel>? appointments =
                          value.appointments.data?.appointments;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: appointments?.map((e) {
                              return BMAppointmentComponent(element: e);
                            }).toList() ??
                            [Center(child: Text('No appointments'))],
                      );
                    default:
                      return Container();
                  }
                }),
              ),
              20.height,
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
