import 'package:beamer/beamer.dart';
import 'package:expertis/components/shop_contact_component.dart';
import 'package:expertis/components/shop_info_component.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopInfoScreen extends StatefulWidget {
  bool isAdmin = false;
  ShopModel? shop;
  ShopInfoScreen({Key? key, this.isAdmin = false, this.shop}) : super(key: key);

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  @override
  void initState() {
    if (widget.isAdmin == false) {
      print("not a admin");
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);
      widget.shop = userViewModel.user?.shop?.first;
      print(" shop id ${widget.shop?.id}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("shop id ${widget.shop?.id}");
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            titleText(title: "About Shop"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText(title: "Shop Info"),
                IconButton(
                    onPressed: (() {
                      if (widget.isAdmin == true) {
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
            ShopInfoComponent(shop: widget.shop),
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

                      if (widget.isAdmin == true) {
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
            ShopContactComponent(contact: widget.shop?.contact),
          ],
        ),
      ),
    ).paddingAll(16);
  }
}
