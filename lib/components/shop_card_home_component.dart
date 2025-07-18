import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/BMColors.dart';

class ShopCardHomeComponent extends StatefulWidget {
  ShopModel element;
  bool fullScreenComponent;
  bool isFavList;

  ShopCardHomeComponent(
      {super.key,
      required this.element,
      required this.fullScreenComponent,
      required this.isFavList});

  @override
  State<ShopCardHomeComponent> createState() => _ShopCardHomeComponentState();
}

class _ShopCardHomeComponentState extends State<ShopCardHomeComponent> {
  bool isLiked = false;
  bool saveTag = false;
  late List<String>? favoriteShops;

  @override
  void initState() {
    favoriteShops =
        Provider.of<UserViewModel>(context, listen: false).user?.favoriteShops;

    if (favoriteShops != null) {
      favoriteShops.forEachIndexed((element, index) {
        if (element == widget.element.id) {
          isLiked = true;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    return Container(
      width: widget.fullScreenComponent ? context.width() - 32 : 250,
      decoration:
          BoxDecoration(color: context.cardColor, borderRadius: radius(32)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.element.shopLogo ?? Assets.defaultShopImage,
                width: widget.fullScreenComponent ? context.width() - 32 : 250,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/image-not-found.jpg',
                    fit: BoxFit.cover,
                    width:
                        widget.fullScreenComponent ? context.width() - 32 : 250,
                    height: 150),
              ).cornerRadiusWithClipRRectOnly(topLeft: 32, topRight: 32),
              saveTag
                  ? Container(
                      color: bmTextColorDarkMode.shade400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer_rounded,
                              color: Color(0xff808080), size: 16),
                          2.width,
                          Text(
                            'Save up to 20% for next booking!',
                            style: secondaryTextStyle(
                                color: const Color(0xff636161)),
                          ).expand(),
                        ],
                      ),
                    )
                  : const Offstage(),
              8.height,
              Text(widget.element.shopName ?? '',
                      style: boldTextStyle(
                          size: 18,
                          color: appStore.isDarkModeOn
                              ? Colors.white
                              : bmSpecialColorDark))
                  .paddingSymmetric(horizontal: 8),
              4.height,
              Text(widget.element.contact!.address ?? '',
                      style: secondaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmPrimaryColor,
                          size: 12))
                  .paddingSymmetric(horizontal: 8),
              4.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      4.width,
                      Text(widget.element.rating!.avg.toString(),
                          style: boldTextStyle()),
                      2.width,
                      Text(
                          '(${widget.element.rating!.totalMembers.toString()}) reviews',
                          style: secondaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmPrimaryColor)),
                    ],
                  ),
                  Text(widget.element.isOpen == true ? 'Open ' : 'Closed',
                      style: secondaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmPrimaryColor)),
                ],
              ).paddingSymmetric(horizontal: 8),
              16.height,
            ],
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(
              Icons.favorite,
              color: isLiked ? Colors.amber : bmTextColorDarkMode,
              size: 24,
            ).onTap(() {
              userViewModel.addOrRemoveFavApi(
                  isLiked, widget.element.id, context);
              setState(() {
                isLiked = !isLiked;
              });
            }),
          )
        ],
      ),
    ).onTap(() {
      String routeName = RoutesName.viewShopWithId(widget.element.shopId);
      Beamer.of(context).beamToNamed(routeName);
      //Navigator.pushNamed(context, "/shop/details", arguments: widget.element);
      // BMSingleComponentScreen(element: widget.element).launch(context);
    });
  }
}
