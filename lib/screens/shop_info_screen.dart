import 'package:flutter/material.dart';

class ShopInfoScreen extends StatefulWidget {
  ShopInfoScreen({Key? key}) : super(key: key);

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ShopInfoScreen'),
    );
  }
}
