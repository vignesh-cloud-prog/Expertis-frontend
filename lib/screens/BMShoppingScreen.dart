import 'package:expertis/components/BMShopComponent.dart';
import 'package:expertis/screens/BMPurchaseMoreScreen.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMShoppingScreen extends StatefulWidget {
  bool isOrders;

  BMShoppingScreen({super.key, required this.isOrders});

  @override
  State<BMShoppingScreen> createState() => _BMShoppingScreenState();
}

class _BMShoppingScreenState extends State<BMShoppingScreen> {
  List<String> tabList = ['ALL PRODUCTS', 'HAIR CARE', 'COSMETIC', 'SKIN CARE'];

  int selectedTab = 0;

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
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
        elevation: 0,
        iconTheme: const IconThemeData(color: bmPrimaryColor),
        leadingWidth: 30,
        title: titleText(title: widget.isOrders ? 'Orders' : 'Shopping'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: appStore.isDarkModeOn
                ? bmSecondBackgroundColorDark
                : bmSecondBackgroundColorLight,
            borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.isOrders
                  ? const Offstage()
                  : Column(
                      children: [
                        HorizontalList(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: tabList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: radius(32),
                                color: selectedTab == index
                                    ? bmPrimaryColor
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                tabList[index],
                                style: boldTextStyle(
                                  size: 12,
                                  color: selectedTab == index
                                      ? white
                                      : appStore.isDarkModeOn
                                          ? bmPrimaryColor
                                          : bmSpecialColorDark,
                                ),
                              ).onTap(() {
                                selectedTab = index;
                                setState(() {});
                              }),
                            );
                          },
                        ),
                        16.height,
                        Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bmPrimaryColor.withAlpha(50),
                            borderRadius: radius(100),
                            border: Border.all(color: bmPrimaryColor),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AppTextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: const Icon(Icons.search_sharp,
                                    color: bmPrimaryColor),
                                hintText: 'Search for Products',
                                hintStyle:
                                    boldTextStyle(color: bmPrimaryColor)),
                            textFieldType: TextFieldType.NAME,
                            cursorColor: bmPrimaryColor,
                          ),
                        ),
                        16.height,
                        Column(
                          children: getProductList().map((e) {
                            return BMShopComponent(element: e);
                          }).toList(),
                        ),
                      ],
                    ),
              widget.isOrders
                  ? const PurchaseMoreScreen().withSize(
                      width: context.width(), height: context.height())
                  : const Offstage(),
              40.height,
            ],
          ),
        ),
      ),
    );
  }
}
