import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMFloatingActionComponent.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMTopOffersScreen extends StatefulWidget {
  const BMTopOffersScreen({super.key});
  @override
  State<BMTopOffersScreen> createState() => _BMTopOffersScreenState();
}

class _BMTopOffersScreenState extends State<BMTopOffersScreen> {
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
        title: titleText(title: 'Top Offers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp, size: 30, color: bmPrimaryColor),
            onPressed: () {
              const PurchaseMoreScreen(enableAppbar: true).launch(context);
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
