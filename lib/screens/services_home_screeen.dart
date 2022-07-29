import 'package:beamer/beamer.dart';
import 'package:expertis/components/service_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMAppointmentComponent.dart';

class ServicesHomeScreen extends StatefulWidget {
  String? shopId;
  ServicesHomeScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ServicesHomeScreen> createState() => _ServicesHomeScreenState();
}

class _ServicesHomeScreenState extends State<ServicesHomeScreen> {
  final shopViewModel = ShopViewModel();
  @override
  void initState() {
    if (widget.shopId == null) {
      UserViewModel.getUser().then((value) => {
            shopViewModel
                .fetchServicesDataApi(value.shop!.first) //widget.shopId
          });
    } else {
      shopViewModel.fetchServicesDataApi(widget.shopId); //widget.shopId
    }

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
              onTap: () {
                Beamer.of(context).beamToNamed(RoutesName.createService);
              },
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
                    print("value ${value.services.data}");
                    List<Services>? services = value.services.data?.services;
                    return services!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.services.data?.services?.length,
                            itemBuilder: (ctx, index) {
                              return ServiceCardComponent(
                                  element:
                                      value.services.data?.services![index]);
                            })
                        : Center(
                            child: Text('No Services'),
                          );

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
