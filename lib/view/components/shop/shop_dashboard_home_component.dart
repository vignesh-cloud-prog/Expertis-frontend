import 'package:expertis/components/shop_analytics_card_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopDashBoardHomeComponent extends StatefulWidget {
  String? shopId;

  ShopDashBoardHomeComponent({super.key, this.shopId});

  @override
  State<ShopDashBoardHomeComponent> createState() =>
      _ShopDashBoardHomeComponentState();
}

class _ShopDashBoardHomeComponentState
    extends State<ShopDashBoardHomeComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ShopAnalyticCards(
        shopId: widget.shopId,
      ),
    ).paddingAll(16);
  }
}
