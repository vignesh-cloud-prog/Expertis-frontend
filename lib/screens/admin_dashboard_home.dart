import 'package:expertis/components/admin_analytics_cards_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AdminDashBoardHomeScreen extends StatefulWidget {
  const AdminDashBoardHomeScreen({super.key});

  @override
  State<AdminDashBoardHomeScreen> createState() =>
      _AdminDashBoardHomeScreenState();
}

class _AdminDashBoardHomeScreenState extends State<AdminDashBoardHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: AnalyticCards(),
    ).paddingAll(16);
  }
}
