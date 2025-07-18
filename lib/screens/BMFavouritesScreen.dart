import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMFavouritesScreen extends StatefulWidget {
  const BMFavouritesScreen({super.key});

  @override
  _BMFavouritesScreenState createState() => _BMFavouritesScreenState();
}

class _BMFavouritesScreenState extends State<BMFavouritesScreen> {
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
        title: titleText(title: 'Favourites'),
      ),
      body: const PurchaseMoreScreen(),
    );
  }
}
