import 'package:expertis/components/about_shop_component.dart';
import 'package:expertis/components/shop_reviews_component.dart';
import 'package:expertis/components/shop_services_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/services/firebase_dynamic_link.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expertis/components/BMPortfolioComponent.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';

class ShopViewScreen extends StatefulWidget {
  final String shopId;
  final int selectedTab;

  const ShopViewScreen({Key? key, required this.shopId, this.selectedTab = 0})
      : super(key: key);

  @override
  ShopViewScreenState createState() => ShopViewScreenState();
}

class ShopViewScreenState extends State<ShopViewScreen> {
  ShopModel? shop;
  int selectedTab = 0;
  String? id = "";
  ShopViewModel shopViewModel = ShopViewModel();
  bool isLiked = false;
  String defaultImg = "https://www.totallyrepair.in/images/wow-5.jpg";
  List<String> tabList = ['OUR SERVICES', 'ABOUT', 'REVIEW'];

  Widget getSelectedTabComponent() {
    switch (selectedTab) {
      case 0:
        return const ShopServiceComponent();
      // case 1:
      //   return BMPortfolioComponent();
      case 1:
        return AboutShopComponent(
          shop: shop,
        );
      case 2:
        print("shop id in shop detail screen ${id}");
        return ShopReviewComponent(
          shopId: id,
        );

      default:
        return const ShopServiceComponent();
    }
  }

  String navigateToTab(int index) {
    if (index == 0) {
      return RoutesName.shopsServicesWithId(widget.shopId);
    } else if (index == 1) {
      return RoutesName.shopPortfolioWithId(widget.shopId);
    } else if (index == 2) {
      return RoutesName.aboutShopWithId(widget.shopId);
    } else if (index == 3) {
      return RoutesName.shopReviewsWithId(id);
    }
    return RoutesName.shopsServicesWithId(widget.shopId);
  }

  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    shopViewModel.fetchSelectedShopDataApi(widget.shopId, id: false);
    setState(() {
      selectedTab = widget.selectedTab;
    });
    super.initState();
  }

  @override
  void dispose() {
    shopViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.shopId);
    bool isLiked = false;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: ChangeNotifierProvider<ShopViewModel>.value(
        value: shopViewModel,
        child: Consumer<ShopViewModel>(builder: (context, value, _) {
          switch (value.selectedShop.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              String error = value.selectedShop.message.toString();
              return Utils.findErrorPage(context, error);

            case Status.COMPLETED:
              shop = value.selectedShop.data;
              id = shop?.id;
              if (kDebugMode) {
                // print(shop!.toJson());
              }
              return NestedScrollView(
                floatHeaderSlivers: true,
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: appStore.isDarkModeOn
                          ? appStore.scaffoldBackground!
                          : bmLightScaffoldBackgroundColor,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: bmPrimaryColor),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                      ).visible(innerBoxIsScrolled),
                      title: titleText(title: shop?.shopName ?? '')
                          .visible(innerBoxIsScrolled),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.subdirectory_arrow_right,
                              color: bmPrimaryColor),
                          onPressed: () {
                            // BMSingleImageScreen(element: widget.element)
                            //     .launch(context);
                          },
                        ).visible(innerBoxIsScrolled),
                        IconButton(
                          icon: isLiked
                              ? Icon(Icons.favorite, color: bmPrimaryColor)
                              : Icon(Icons.favorite_outline,
                                  color: bmPrimaryColor),
                          onPressed: () {
                            isLiked = !isLiked;
                            setState(() {});
                          },
                        ).visible(innerBoxIsScrolled),
                      ],
                      leadingWidth: 30,
                      pinned: true,
                      elevation: 0.5,
                      expandedHeight: 450,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding:
                            EdgeInsets.only(bottom: 66, left: 30, right: 50),
                        collapseMode: CollapseMode.parallax,
                        background: Column(
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                  shop?.shopLogo ?? Assets.defaultShopImage,
                                  height: 300,
                                  width: context.width(),
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Icon(Icons.arrow_back,
                                          color: bmPrimaryColor),
                                      decoration: BoxDecoration(
                                        borderRadius: radius(100),
                                        color: context.cardColor,
                                      ),
                                      padding: EdgeInsets.all(8),
                                      margin:
                                          EdgeInsets.only(left: 16, top: 30),
                                    ).onTap(() {
                                      finish(context);
                                    }, borderRadius: radius(100)),
                                    Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                              Icons.subdirectory_arrow_right,
                                              color: bmPrimaryColor),
                                          decoration: BoxDecoration(
                                            borderRadius: radius(100),
                                            color: context.cardColor,
                                          ),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(
                                              right: 16, top: 30),
                                        ).onTap(() {
                                          // BMSingleImageScreen(
                                          //         element: widget.element)
                                          //     .launch(context);
                                        }, borderRadius: radius(100)),
                                        Container(
                                          child: isLiked
                                              ? Icon(Icons.favorite,
                                                  color: bmPrimaryColor)
                                              : Icon(Icons.favorite_outline,
                                                  color: bmPrimaryColor),
                                          decoration: BoxDecoration(
                                            borderRadius: radius(100),
                                            color: context.cardColor,
                                          ),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(
                                              right: 16, top: 30),
                                        ).onTap(() {
                                          isLiked = !isLiked;
                                          setState(() {});
                                        }, borderRadius: radius(100)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              color: appStore.isDarkModeOn
                                  ? appStore.scaffoldBackground!
                                  : bmLightScaffoldBackgroundColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleText(title: shop?.shopName ?? ''),
                                  8.height,
                                  Text(
                                    shop?.contact?.address ?? '',
                                    style: secondaryTextStyle(
                                        color: appStore.isDarkModeOn
                                            ? Colors.white
                                            : bmPrimaryColor,
                                        size: 12),
                                  ),
                                  8.height,
                                  Row(
                                    children: [
                                      Text('${shop?.rating?.avg}',
                                          style: boldTextStyle()),
                                      2.width,
                                      RatingBar(
                                        initialRating:
                                            shop?.rating?.avg?.toDouble(),
                                        minRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 18,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          //
                                        },
                                      ),
                                      6.width,
                                      Text(
                                          '${shop?.rating?.totalMembers ?? 0} reviews',
                                          style: secondaryTextStyle(
                                              color: bmTextColorDarkMode)),
                                    ],
                                  ),
                                  8.height,
                                  Wrap(
                                    spacing: 16,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: bmPrimaryColor),
                                          color: appStore.isDarkModeOn
                                              ? appStore.scaffoldBackground!
                                              : bmLightScaffoldBackgroundColor,
                                          borderRadius: radius(32),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.call_outlined,
                                                color: bmPrimaryColor),
                                            4.width,
                                            Text('Call us',
                                                style: boldTextStyle(
                                                    color: bmPrimaryColor)),
                                          ],
                                        ),
                                      ).onTap(() {
                                        // BMCallScreen().launch(context);
                                        launchUrl(Uri(
                                            scheme: 'tel',
                                            path: shop?.contact!.phone
                                                .toString()));
                                      }, borderRadius: radius(32)),
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: bmPrimaryColor),
                                          color: appStore.isDarkModeOn
                                              ? appStore.scaffoldBackground!
                                              : bmLightScaffoldBackgroundColor,
                                          borderRadius: radius(32),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset('images/chat.png',
                                                height: 20,
                                                color: bmPrimaryColor),
                                            8.width,
                                            Text('Send Message',
                                                style: boldTextStyle(
                                                    color: bmPrimaryColor)),
                                          ],
                                        ),
                                      ).onTap(() {
                                        // BMChatScreen(
                                        //     element: BMMessageModel(
                                        //   image: widget.element.image,
                                        //   name: widget.element.title,
                                        //   message: 'Do you want to confirm yor appointment?',
                                        //   isActive: false,
                                        //   lastSeen: 'today , at 11:30 am',
                                        // )).launch(context);
                                        final Uri smsLaunchUri = Uri(
                                          scheme: 'sms',
                                          path: shop?.contact!.phone.toString(),
                                          queryParameters: <String, String>{
                                            'body':
                                                'Hello, is seats available now?',
                                          },
                                        );
                                        launchUrl(smsLaunchUri);
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn
                        ? bmSecondBackgroundColorDark
                        : bmSecondBackgroundColorLight,
                    borderRadius: radiusOnly(topLeft: 32, topRight: 32),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        16.height,
                        HorizontalList(
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
                                setState(() {
                                  selectedTab = index;
                                });
                              }),
                            );
                          },
                        ),
                        getSelectedTabComponent(),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
