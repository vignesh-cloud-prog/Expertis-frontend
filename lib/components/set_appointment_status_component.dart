import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class SetAppointmentStatus extends StatefulWidget {
  final String appointmentId;
  final String status;
  const SetAppointmentStatus(
      {Key? key, required this.appointmentId, required this.status})
      : super(key: key);

  @override
  State<SetAppointmentStatus> createState() => _SetAppointmentStatusState();
}

class _SetAppointmentStatusState extends State<SetAppointmentStatus> {
  final appointmentViewModel = AppointmentViewModel();

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
    appointmentViewModel.updateAppointmentStatusApi(
        widget.appointmentId, widget.status);
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

            return Scaffold(
              backgroundColor: appStore.isDarkModeOn
                  ? appStore.scaffoldBackground!
                  : bmLightScaffoldBackgroundColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/check.png', height: 200),
                    Text('${widget.status.toUpperCase()}ED',
                        style: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark,
                            size: 30)),
                    16.height,
                    Text(
                      "Your appointment has been ${widget.status.toUpperCase()}ED",
                      style: secondaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? Colors.white
                              : bmSpecialColorDark),
                      textAlign: TextAlign.center,
                    ),
                    16.height,
                    AppButton(
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: Text('View Appointments',
                          style: boldTextStyle(color: Colors.white)),
                      padding: EdgeInsets.all(16),
                      width: 150,
                      color: bmPrimaryColor,
                      onTap: () {
                        Beamer.of(context)
                            .beamToReplacementNamed(RoutesName.appointment);
                      },
                    ),
                  ],
                ).paddingAll(20),
              ),
            );

          default:
            return Container();
        }
      }),
    );
  }
}
