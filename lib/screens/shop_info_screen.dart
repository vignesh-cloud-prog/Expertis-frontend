import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopInfoScreen extends StatefulWidget {
  bool isadmin;
  ShopModel? shop;
  ShopInfoScreen({Key? key, required this.isadmin, this.shop})
      : super(key: key);

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  ShopModel? shop;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isadmin) {
      print("not a admin");
      UserViewModel userViewModel = Provider.of<UserViewModel>(context);
      widget.shop = userViewModel.user.shop?.first;
      print(" shop id ${widget.shop?.id}");
    } else {
      print("is a admin ${widget.shop?.id}");
      // shop = widget.shop;
    }
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
                      if (widget.isadmin) {
                        print("shop on press ${widget.shop?.shopName}");
                        Beamer.of(context).beamToNamed(
                            RoutesName.adminUpdateShopInfo,
                            data: widget.shop);
                      } else {
                        Beamer.of(context).beamToNamed(
                            RoutesName.updateShopInfo,
                            data: widget.shop);
                      }
                    }),
                    icon: Icon(Icons.edit)),
              ],
            ),
            ShopInfoComponent(shop: shop),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText(title: "Shop Contact"),
                IconButton(
                    onPressed: (() {
                      // Beamer.of(context).beamToNamed(
                      //     RoutesName.updateShopContactWithId(widget.shop?.id),
                      //     data: widget.shop);

                      if (widget.isadmin) {
                        // print("shop on press ${widget.shop?.shopName}");
                        Beamer.of(context).beamToNamed(
                            RoutesName.adminUpdateShopContact,
                            data: widget.shop);
                      } else {
                        Beamer.of(context).beamToNamed(
                            RoutesName.updateShopContactWithId(widget.shop?.id),
                            data: widget.shop);
                      }
                    }),
                    icon: Icon(Icons.edit)),
              ],
            ),
            ShopContactComponent(contact: shop?.contact),
          ],
        ),
      ),
    ).paddingAll(16);
  }
}
