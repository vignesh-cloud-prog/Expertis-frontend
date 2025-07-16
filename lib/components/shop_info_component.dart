import 'package:expertis/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopInfoComponent extends StatelessWidget {
  final ShopModel? shop;
  const ShopInfoComponent({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        Text("${shop?.shopName} ( ${shop?.shopId} )",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Row(
          children: [
            const Icon(Icons.person),
            Text(
              shop?.gender?.toLowerCase().capitalizeFirstLetter() ?? "",
              style: boldTextStyle(),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
