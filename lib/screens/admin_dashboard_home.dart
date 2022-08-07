import 'package:expertis/components/analytics_cards_component.dart';
import 'package:flutter/material.dart';

class AdminDashBoardHomeScreen extends StatefulWidget {
  AdminDashBoardHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashBoardHomeScreen> createState() =>
      _AdminDashBoardHomeScreenState();
}

class _AdminDashBoardHomeScreenState extends State<AdminDashBoardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnalyticCards(),
    );
  }
}
