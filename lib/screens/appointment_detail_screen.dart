import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMAvailabilityComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/BMServiceListModel.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/appointment_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class ViewAppointmentScreen extends StatefulWidget {
  final String? appointmentId;

  const ViewAppointmentScreen({Key? key, this.appointmentId}) : super(key: key);

  @override
  ViewAppointmentScreenState createState() => ViewAppointmentScreenState();
}

class ViewAppointmentScreenState extends State<ViewAppointmentScreen> {
  final appointmentViewModel = AppointmentViewModel();
  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    appointmentViewModel.fetchSelectedAppointment(widget.appointmentId ?? '');
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserViewModel>(context).user;
    print(user.id);
    return ChangeNotifierProvider<AppointmentViewModel>.value(
      value: appointmentViewModel,
      child: Consumer<AppointmentViewModel>(builder: (context, value, _) {
        switch (value.selectedAppointment.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.ERROR:
            String error = value.selectedAppointment.message.toString();
            return Utils.findErrorPage(context, error);

          case Status.COMPLETED:
            AppointmentModel? appointment = value.selectedAppointment.data;
            if (kDebugMode) {
              print(appointment!.toJson());
            }
            return Scaffold(
                backgroundColor: appStore.isDarkModeOn
                    ? appStore.scaffoldBackground!
                    : bmLightScaffoldBackgroundColor,
                appBar: appBar(
                  context,
                  "Appointment",
                  subtitle: appointment?.appointmentStatus ?? '',
                ),
                body: CustomScrollView(
                  //  Column(
                  //       children: appointment!.services
                  //               ?.map((e) => Container(
                  //                     child: ServiceComponent(element: e),
                  //                   ))
                  //               .toList() ??
                  //           [])
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, int) {
                      return Text('Boo');
                    }, childCount: 65)),
                    SliverFillRemaining(
                      child: Text('Foo Text'),
                    ),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (appointment?.paymentStatus == "PENDING" &&
                          appointment?.memberId.toString() ==
                              user.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              side: BorderSide(color: bmSpecialColor),
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Reject',
                              style: boldTextStyle(color: Colors.red[300])),
                          padding: EdgeInsets.all(16),
                          width: 150,

                          // color: bmPrimaryColor,
                          onTap: () {
                            // Beamer.of(context).beamToReplacementNamed(RoutesName.login);
                          },
                        ).expand(flex: 1)
                      else if (appointment?.paymentStatus == "PENDING" &&
                          appointment?.memberId.toString() !=
                              user.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              side: BorderSide(color: bmSpecialColor),
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Cancel',
                              style: boldTextStyle(color: Colors.red[300])),
                          padding: EdgeInsets.all(16),
                          width: 150,

                          // color: bmPrimaryColor,
                          onTap: () {
                            // Beamer.of(context).beamToReplacementNamed(RoutesName.login);
                          },
                        ).expand(flex: 1),
                      if (appointment?.paymentStatus == "PENDING" &&
                          appointment?.memberId.toString() ==
                              user.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Confirm',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            // Beamer.of(context).beamToReplacementNamed(RoutesName.login);
                          },
                        ).expand(flex: 2)
                      else if (appointment?.paymentStatus == "PENDING" &&
                          appointment?.memberId.toString() !=
                              user.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Edit Booking',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            // Beamer.of(context).beamToReplacementNamed(RoutesName.login);
                          },
                        ).expand(flex: 2),
                    ],
                  ),
                ));

          default:
            return Container();
        }
      }),
    );
  }
}
