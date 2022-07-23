import 'package:beamer/beamer.dart';
import 'package:expertis/components/BMCommentComponent.dart';
import 'package:expertis/components/review_component.dart';
import 'package:expertis/models/BMCommentModel.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ShopReviewComponent extends StatelessWidget {
  const ShopReviewComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BMCommentModel> list = getCommentsList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: bmPrimaryColor),
            color: appStore.isDarkModeOn
                ? appStore.scaffoldBackground!
                : bmLightScaffoldBackgroundColor,
            borderRadius: radius(18),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit, color: bmPrimaryColor),
              8.width,
              Text('Write a Review',
                  style: boldTextStyle(color: bmPrimaryColor)),
            ],
          ).expand().center(),
        ).paddingAll(8),
        16.height,
        Row(
          children: [
            titleText(title: 'Reviews', size: 20),
            2.width,
            titleText(
              title: '(240 reviews)',
              size: 16,
            ),
          ],
        ).paddingOnly(top: 8, bottom: 8, left: 10),
        10.height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: list.map((e) {
            return ReviewComponent(element: e);
          }).toList(),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
