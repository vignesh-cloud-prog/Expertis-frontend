import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/screens/shop_info_screen.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:flutter/material.dart';

class AdminShopInfoScreen extends StatefulWidget {
  ShopModel? shop;
  AdminShopInfoScreen({Key? key, required this.shop}) : super(key: key);

  @override
  State<AdminShopInfoScreen> createState() => _AdminShopInfoScreenState();
}

class _AdminShopInfoScreenState extends State<AdminShopInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("data in admin shop screen ${widget.shop?.toString()}");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bmSpecialColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
        title: Text(
          widget.shop?.shopName ?? "",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ShopInfoScreen(
        isAdmin: true,
        shop: widget.shop,
      ),
    );
  }
}
