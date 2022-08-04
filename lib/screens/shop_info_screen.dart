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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    ShopModel? shop = userViewModel.user.shop?.first;
    return Container(
      child: SingleChildScrollView(
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
      ),
    ).paddingAll(16);
  }
}
