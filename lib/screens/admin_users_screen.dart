import 'package:beamer/beamer.dart';
import 'package:expertis/components/service_card_component.dart';
import 'package:expertis/components/shop_card_component.dart';
import 'package:expertis/components/user_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
// import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:expertis/view_model/user_list_view_model.dart';
// import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointmentComponent.dart';

class AdminUsersHomeScreen extends StatefulWidget {
  AdminUsersHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersHomeScreen> createState() => _AdminUsersHomeScreenState();
}

class _AdminUsersHomeScreenState extends State<AdminUsersHomeScreen> {
  final userListViewModel = UserListViewModel();
  @override
  void initState() {
    userListViewModel.fetchUserData(); //widget.shopId

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChangeNotifierProvider<UserListViewModel>.value(
              value: userListViewModel,
              child: Consumer<UserListViewModel>(builder: (context, value, _) {
                switch (value.userList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                      child: Text(value.userList.message.toString()),
                    );
                  case Status.COMPLETED:
                    print(
                        "value ${value.userList.data?.users?.first.toJson()}");
                    // print("printed ${value.services.data.toString()}");
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.userList.data?.users?.length,
                        itemBuilder: (ctx, index) {
                          return UserCardComponent(
                              element: value.userList.data?.users![index]);
                        });
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
        ),
      ),
    );
  }
}
