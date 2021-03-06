import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopInfoScreen extends StatefulWidget {
  ShopInfoScreen({Key? key}) : super(key: key);

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  ShopViewModel shopViewModel = ShopViewModel();
  @override
  void initState() {
    UserViewModel.getUser().then((value) =>
        {shopViewModel.fetchSelectedShopDataApi(value.shop?.first ?? '')});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<ShopViewModel>.value(
        value: shopViewModel,
        child: Consumer<ShopViewModel>(builder: (context, value, _) {
          switch (value.selectedShop.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              String error = value.selectedShop.message.toString();
              return Utils.findErrorPage(context, error);

            case Status.COMPLETED:
              ShopModel? shop = value.selectedShop.data;
              if (kDebugMode) {
                print(shop!.toJson());
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    titleText(title: "About My Shop"),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleText(title: "Shop Info"),
                        IconButton(
                            onPressed: (() {
                              Beamer.of(context).beamToNamed(
                                  RoutesName.updateShopInfoWithId(shop?.id),
                                  data: shop);
                            }),
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleText(title: "Shop Contact"),
                        IconButton(
                            onPressed: (() {
                              Beamer.of(context).beamToNamed(
                                  RoutesName.updateShopContactWithId(shop?.id),
                                  data: shop);
                            }),
                            icon: Icon(Icons.edit)),
                      ],
                    )
                  ],
                ),
              );
            default:
              return Container();
          }
        }),
      ),
    ).paddingAll(16);
  }
}
