import 'package:beamer/beamer.dart';
import 'package:expertis/components/service_card_component.dart';
import 'package:expertis/components/shop_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
// import 'package:expertis/view_model/user_list_view_model.dart';
// import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointmentComponent.dart';

class AdminShopsHomeScreen extends StatefulWidget {
  AdminShopsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminShopsHomeScreen> createState() => _AdminShopsHomeScreenState();
}

class _AdminShopsHomeScreenState extends State<AdminShopsHomeScreen> {
  final shopListViewModel = ShopListViewModel();
  @override
  void initState() {
    shopListViewModel.fetchShopsDataApi(); //widget.shopId

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChangeNotifierProvider<ShopListViewModel>.value(
              value: shopListViewModel,
              child: Consumer<ShopListViewModel>(builder: (context, value, _) {
                switch (value.shopList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                      child: Text(value.shopList.message.toString()),
                    );
                  case Status.COMPLETED:
                    // print("value ${value.shopList.data?.toJson()}");
                    // print("printed ${value.services.data.toString()}");
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.shopList.data?.shops?.length,
                        itemBuilder: (ctx, index) {
                          return ShopCardComponent(
                              element: value.shopList.data?.shops![index]);
                        });
                  default:
                    return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
