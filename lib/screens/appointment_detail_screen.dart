import 'package:beamer/beamer.dart';
import 'package:expertis/components/service_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
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
    UserModel? user = Provider.of<UserViewModel>(context).user;
    print(user?.id);
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
            List<Members> members =
                appointment?.shopId?.members as List<Members>;
            Members member = members.firstWhere(
                (element) => element.member == appointment!.memberId);
            print('members.first.id ${members.first.member}');
            print('appointment?.memberId ${appointment?.memberId}');
            if (kDebugMode) {
              print(appointment?.toJson());
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
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      titleText(title: "Services"),
                      20.height,
                      Column(
                          children: appointment!.services
                                  ?.map((e) => Container(
                                        width: double.infinity,
                                        child: ServiceComponent(element: e),
                                      ))
                                  .toList() ??
                              []),
                      8.height,
                      Text("By: ${member.name}"),
                      20.height,
                      titleText(title: "Booking Scheduled"),
                      Text(
                          "from: ${DateFormat('hh:MM a EEEE dd MMMM yyyy').format(DateTime.parse(appointment.startTime ?? ''))}"),
                      Text(
                          "To: ${DateFormat('hh:MM a EEEE dd MMMM yyyy').format(DateTime.parse(appointment.endTime ?? ''))}"),
                      20.height,
                      titleText(title: "Shop Details"),
                      Text(appointment.shopId?.shopName ?? ''),
                      Text(appointment.shopId?.contact?.address ?? ''),
                      Text(appointment.shopId?.contact?.phone.toString() ?? ''),
                      20.height,
                      titleText(title: "Summary"),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Time: "),
                              Text("${appointment.totalTime} min"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Price: "),
                              Text("${appointment.totalPrice} Rs"),
                            ],
                          ),
                        ],
                      )
                    ],
                  ).paddingAll(20),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (appointment.appointmentStatus == "PENDING" &&
                          appointment.memberId.toString() ==
                              user?.id.toString())
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
                            Beamer.of(context).beamToReplacementNamed(
                                RoutesName.getSetAppointmentStatusURL(
                                    appointment.id, 'reject'),
                                data: appointment);
                          },
                        ).expand(flex: 1)
                      else if (appointment.appointmentStatus == "PENDING" &&
                          appointment.memberId.toString() !=
                              user?.id.toString())
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
                            Beamer.of(context).beamToReplacementNamed(
                                RoutesName.getSetAppointmentStatusURL(
                                    appointment.id, 'cancel'),
                                data: appointment);
                          },
                        ).expand(flex: 1),
                      if (appointment.appointmentStatus == "PENDING" &&
                          appointment.memberId.toString() ==
                              user?.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Accept',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            Beamer.of(context).beamToReplacementNamed(
                              RoutesName.getSetAppointmentStatusURL(
                                  appointment.id, 'accept'),
                            );
                          },
                        ).expand(flex: 2)
                      // else if (appointment.appointmentStatus == "PENDING" &&
                      //     appointment.memberId.toString() !=
                      //         user?.id.toString())
                      //   AppButton(
                      //     shapeBorder: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(32)),
                      //     child: Text('Edit Booking',
                      //         style: boldTextStyle(color: Colors.white)),
                      //     padding: EdgeInsets.all(16),
                      //     color: bmPrimaryColor,
                      //     onTap: () {
                      //       // Beamer.of(context).beamToReplacementNamed(RoutesName.login);
                      //     },
                      //   ).expand(flex: 2)
                      else if (appointment.appointmentStatus == "ACCEPTED" &&
                          appointment.memberId.toString() !=
                              user?.id.toString())
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Mark as Completed',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            Beamer.of(context).beamToReplacementNamed(
                              RoutesName.getSetAppointmentStatusURL(
                                  appointment.id, 'complete'),
                            );
                          },
                        ).expand(flex: 2)
                      else if (appointment.appointmentStatus == "CANCELLED" ||
                          appointment.appointmentStatus == "REJECTED" ||
                          appointment.appointmentStatus == "COMPLETED")
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Go Back',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () {
                            Navigator.of(context).maybePop();
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
