import 'package:expertis/components/shop_analytics_card_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopDashBoardHomeScreen extends StatefulWidget {
  ShopDashBoardHomeScreen({Key? key}) : super(key: key);

  @override
  State<ShopDashBoardHomeScreen> createState() =>
      _ShopDashBoardHomeScreenState();
}

class _ShopDashBoardHomeScreenState extends State<ShopDashBoardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ShopAnalyticCards(),
    ).paddingAll(16);
  }
}
