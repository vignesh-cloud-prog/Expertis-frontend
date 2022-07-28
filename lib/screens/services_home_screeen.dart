import 'package:expertis/components/service_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointmentComponent.dart';

class ServicesHomeScreen extends StatefulWidget {
  String shopId;
  ServicesHomeScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ServicesHomeScreen> createState() => _ServicesHomeScreenState();
}

class _ServicesHomeScreenState extends State<ServicesHomeScreen> {
  final shopViewModel = ShopViewModel();
  @override
  void initState() {
    shopViewModel
        .fetchServicesDataApi("62e182bc8a591ad3d983f7f2"); //widget.shopId

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppButton(
              text: 'Add Service',
              onTap: () {},
            ),
            ChangeNotifierProvider<ShopViewModel>.value(
              value: shopViewModel,
              child: Consumer<ShopViewModel>(builder: (context, value, _) {
                switch (value.services.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                      child: Text(value.services.message.toString()),
                    );
                  case Status.COMPLETED:
                    print(
                        "value ${value.services.data?.services?.first.toJson()}");
                    // print("printed ${value.services.data.toString()}");
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.services.data?.services?.length,
                        itemBuilder: (ctx, index) {
                          return ServiceCardComponent(
                              element: value.services.data?.services![index]);
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
