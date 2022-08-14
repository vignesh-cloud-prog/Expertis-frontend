import 'package:expertis/models/shop_model.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopInfoComponent extends StatelessWidget {
  final ShopModel? shop;
  const ShopInfoComponent({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text("${shop?.shopName} ( ${shop?.shopId} )",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Icon(Icons.person),
            Text(
              shop?.gender?.toLowerCase().capitalizeFirstLetter() ?? "",
              style: boldTextStyle(),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(shop?.about ?? ""),
          ],
        ),
      ],
    );
  }
}
