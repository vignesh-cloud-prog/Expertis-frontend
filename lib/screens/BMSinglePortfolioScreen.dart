import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BMCommonCardModel.dart';
import '../utils/BMBottomSheet.dart';
import '../utils/BMColors.dart';

class BMSinglePortfolioScreen extends StatefulWidget {
  BMCommonCardModel element;

  BMSinglePortfolioScreen({super.key, required this.element});

  @override
  _BMSinglePortfolioScreenState createState() =>
      _BMSinglePortfolioScreenState();
}

class _BMSinglePortfolioScreenState extends State<BMSinglePortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.element.image),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {}, // fallback handled below
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: radius(100),
              color: context.cardColor,
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset('images/x.png',
                height: 16, fit: BoxFit.cover, color: bmPrimaryColor),
          ).onTap(() {
            finish(context);
          }),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.element.title,
                      style: boldTextStyle(color: Colors.white, size: 20)),
                  4.height,
                  Text(widget.element.subtitle!,
                      style: secondaryTextStyle(color: Colors.white, size: 12)),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: radius(100),
                      color: context.cardColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: widget.element.liked!
                        ? const Icon(Icons.favorite, color: bmPrimaryColor)
                        : const Icon(Icons.favorite_outline,
                            color: bmPrimaryColor),
                  ).onTap(() {
                    widget.element.liked = !widget.element.liked!;
                    setState(() {});
                  }, borderRadius: radius(100)),
                  8.height,
                  Text(widget.element.likes!,
                      style: secondaryTextStyle(color: Colors.white, size: 12)),
                  20.height,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: radius(100),
                      color: context.cardColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('images/chat.png',
                        height: 16, fit: BoxFit.cover, color: bmPrimaryColor),
                  ).onTap(() {
                    showCommentBottomSheet(context);
                  }, borderRadius: radius(100)),
                  8.height,
                  Text(widget.element.comments!,
                      style: secondaryTextStyle(color: Colors.white, size: 12)),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
