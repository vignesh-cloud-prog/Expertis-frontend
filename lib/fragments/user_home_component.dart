import 'package:beamer/beamer.dart';
import 'package:expertis/components/top_shops_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/components/nearby_shops_component.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../components/shop_card_component.dart';
import '../components/home_page_head_component.dart';
import '../components/category_home_component.dart';
import '../main.dart';
import '../models/BMCommonCardModel.dart';
import '../screens/BMRecommendedScreen.dart';
import '../screens/BMTopOffersScreen.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';
import '../utils/BMWidgets.dart';

class UserHomeComponent extends StatefulWidget {
  const UserHomeComponent({Key? key}) : super(key: key);

  @override
  State<UserHomeComponent> createState() => _UserHomeComponentState();
}

class _UserHomeComponentState extends State<UserHomeComponent> {
  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              upperContainer(
                  child: const HomeFragmentHeadComponent(),
                  screenContext: context),
              lowerContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleText(title: 'Categories'),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                      20.height,
                      const CategoryHomeComponent(),
                      20.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleText(title: 'Top Shops'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Beamer.of(context)
                                      .beamToNamed(RoutesName.viewAllShops);
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
                      BMTopShopsComponent(),

                      20.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleText(title: 'Recommended for You').expand(),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Beamer.of(context)
                                      .beamToNamed(RoutesName.viewAllShops);
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
                      BMNearByShopsComponent(),
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
                  screenContext: context)
            ],
          ),
        ));
  }
}
