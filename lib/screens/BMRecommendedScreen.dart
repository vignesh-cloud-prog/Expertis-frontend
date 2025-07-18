import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMFloatingActionComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMRecommendedScreen extends StatefulWidget {
  const BMRecommendedScreen({super.key});

  @override
  State<BMRecommendedScreen> createState() => _BMRecommendedScreenState();
}

class _BMRecommendedScreenState extends State<BMRecommendedScreen> {
  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: bmPrimaryColor),
          onPressed: () {
            finish(context);
          },
        ),
        title: titleText(title: 'Recommended for you'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp, size: 30, color: bmPrimaryColor),
            onPressed: () {
              finish(context);
            },
          ),
          8.width,
        ],
      ),
      body: const PurchaseMoreScreen(),
      floatingActionButton: const BMFloatingActionComponent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
