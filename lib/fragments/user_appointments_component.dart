import 'package:expertis/components/BMAppointmentComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMColors.dart';

class UserAppointmentsComponent extends StatefulWidget {
  int tabNo = 0;
  UserAppointmentsComponent({Key? key, this.tabNo = 0}) : super(key: key);

  @override
  State<UserAppointmentsComponent> createState() =>
      _UserAppointmentsComponentState();
}

class _UserAppointmentsComponentState extends State<UserAppointmentsComponent> {
  AppointmentListViewModel appointmentViewModel = AppointmentListViewModel();
  List<String> tabList = ['UPCOMING', 'PAST'];
  int selectedTab = 0;
  String userId = '';

  @override
  void initState() {
    UserViewModel.getUser().then((value) => {
          selectedTab = widget.tabNo,
          userId = value.id ?? '',
          appointmentViewModel.getUserAppointmentsApi(
              value.id ?? '', widget.tabNo == 1 ? true : false)
        });

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
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: bmSpecialColor,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).maybePop();
        //   },
        // ),
        title: Text(
          'Appointments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                        children: appointments?.isEmpty == true
                            ? [
                                Center(
                                    child: Text('No appointments found')
                                        .paddingAll(26))
                              ]
                            : appointments!.map((e) {
                                return BMAppointmentComponent(element: e);
                              }).toList(),
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
