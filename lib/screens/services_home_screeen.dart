import 'package:beamer/beamer.dart';
import 'package:expertis/components/service_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/main.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

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
                .fetchServicesDataApi(value.shop!.first.id) //widget.shopId
          });
    } else {
      shopViewModel.fetchServicesDataApi(widget.shopId); //widget.shopId
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          color: bmPrimaryColor,
          textColor: white,
          width: double.infinity,
          text: 'Add Service',
          onTap: () {
            Beamer.of(context).beamToNamed(RoutesName.createService);
          },
        ).paddingAll(16),
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
                    ? Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.services.data?.services?.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color:
                                        appStore.isDarkModeOn ? white : white,
                                    borderRadius: radius(20)),
                                child: ServiceCardComponent(
                                    element:
                                        value.services.data?.services![index]),
                              ).paddingAll(12);
                            }),
                      )
                    : Center(
                        child: Text('No Services'),
                      );

              default:
                return Container();
            }
          }),
        ),
      ],
    );
  }
}
