import 'package:flutter/material.dart';

class ShopDashBoardHomeScreen extends StatefulWidget {
  ShopDashBoardHomeScreen({Key? key}) : super(key: key);

  @override
  State<ShopDashBoardHomeScreen> createState() =>
      _ShopDashBoardHomeScreenState();
}

class _ShopDashBoardHomeScreenState extends State<ShopDashBoardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ShopDashBoardHomeScreen'),
    );
  }
}
