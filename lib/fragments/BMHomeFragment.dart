import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/BMCommonCardComponent.dart';
import '../components/BMHomeFragmentHeadComponent.dart';
import '../components/BMMyMasterComponent.dart';
import '../components/BMTopServiceHomeComponent.dart';
import '../main.dart';
import '../models/BMCommonCardModel.dart';
import '../screens/BMRecommendedScreen.dart';
import '../screens/BMTopOffersScreen.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';
import '../utils/BMWidgets.dart';

class BMHomeFragment extends StatefulWidget {
  const BMHomeFragment({Key? key}) : super(key: key);

  @override
  State<BMHomeFragment> createState() => _BMHomeFragmentState();
}

class _BMHomeFragmentState extends State<BMHomeFragment> {
  List<BMCommonCardModel> specialOffersList = getSpecialOffersList();

  List<BMCommonCardModel> recommendedList = getRecommendedList();
  ShopViewModel shopViewModel = ShopViewModel();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    shopViewModel.fetchShopsDataApi();
    shopViewModel.fetchNearbyShopsDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeFragmentHeadComponent(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(title: 'Top Services'),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              BMTopOffersScreen().launch(context);
                            },
                            child: Text('See All',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmPrimaryColor
                                        : bmTextColorDarkMode)),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: appStore.isDarkModeOn
                                  ? bmPrimaryColor
                                  : bmTextColorDarkMode,
                              size: 16),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  20.height,
                  BMTopServiceHomeComponent(),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(title: 'Special Offers'),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              BMTopOffersScreen().launch(context);
                            },
                            child: Text('See All',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmPrimaryColor
                                        : bmTextColorDarkMode)),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: appStore.isDarkModeOn
                                  ? bmPrimaryColor
                                  : bmTextColorDarkMode,
                              size: 16),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  20.height,
                  ChangeNotifierProvider<ShopViewModel>(
                    create: (BuildContext context) => shopViewModel,
                    child:
                        Consumer<ShopViewModel>(builder: (context, value, _) {
                      switch (value.shopList.status) {
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(
                              child: Text(value.shopList.message.toString()));
                        case Status.COMPLETED:
                          return HorizontalList(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            spacing: 16,
                            itemCount: value.shopList.data!.shops!.length,
                            itemBuilder: (context, index) {
                              return BMCommonCardComponent(
                                  element: value.shopList.data!.shops![index],
                                  fullScreenComponent: false,
                                  isFavList: false);
                            },
                          );
                      }
                      return Container();
                    }),
                  ),

                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(title: 'Recommended for You').expand(),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              BMRecommendedScreen().launch(context);
                            },
                            child: Text('See All',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmPrimaryColor
                                        : bmTextColorDarkMode)),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: appStore.isDarkModeOn
                                  ? bmPrimaryColor
                                  : bmTextColorDarkMode,
                              size: 16),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  20.height,
                  ChangeNotifierProvider<ShopViewModel>(
                    create: (BuildContext context) => shopViewModel,
                    child:
                        Consumer<ShopViewModel>(builder: (context, value, _) {
                      switch (value.nearbyShopList.status) {
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(
                              child: Text(
                                  value.nearbyShopList.message.toString()));
                        case Status.COMPLETED:
                          return HorizontalList(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            spacing: 16,
                            itemCount: value.nearbyShopList.data!.shops!.length,
                            itemBuilder: (context, index) {
                              return BMCommonCardComponent(
                                  element:
                                      value.nearbyShopList.data!.shops![index],
                                  fullScreenComponent: false,
                                  isFavList: false);
                            },
                          );
                      }
                      return Container();
                    }),
                  ),
                  // HorizontalList(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   spacing: 16,
                  //   itemCount: recommendedList.length,
                  //   itemBuilder: (context, index) {
                  //     return BMCommonCardComponent(
                  //         element: recommendedList[index],
                  //         fullScreenComponent: false,
                  //         isFavList: false);
                  //   },
                  // ),
                  40.height,
                ],
              ).cornerRadiusWithClipRRectOnly(topRight: 40),
            ],
          ),
        ));
  }
}
