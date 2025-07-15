import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'BMAppointmentComponent.dart';

class BMAppointMentTabComponent extends StatefulWidget {
  bool tabOne;

  BMAppointMentTabComponent({Key? key, required this.tabOne}) : super(key: key);

  @override
  State<BMAppointMentTabComponent> createState() =>
      _BMAppointMentTabComponentState();
}

class _BMAppointMentTabComponentState extends State<BMAppointMentTabComponent> {
  AppointmentListViewModel appointmentViewModel = AppointmentListViewModel();
  getCurrentDate() {
    return DateFormat.yMMMMd('en_US').format(DateTime.now());
  }

  getTomorrowDate() {
    return DateFormat.yMMMMd('en_US')
        .format(DateTime.now().add(const Duration(days: 1)));
  }

  getYesterdayDate() {
    return DateFormat.yMMMMd('en_US')
        .format(DateTime.now().subtract(const Duration(days: 1)));
  }

  @override
  void initState() {
    UserViewModel.getUser().then((value) => {
          appointmentViewModel.getUserAppointmentsApi(
              value.id ?? '', widget.tabOne)
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppointmentListViewModel>.value(
      value: appointmentViewModel,
      child: Consumer<AppointmentListViewModel>(builder: (context, value, _) {
        switch (value.appointments.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
              child: Text(value.appointments.message.toString()),
            );
          case Status.COMPLETED:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: value.appointments.data?.appointments?.map((e) {
                    return BMAppointmentComponent(element: e);
                  }).toList() ??
                  [],
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
    );
  }
}
