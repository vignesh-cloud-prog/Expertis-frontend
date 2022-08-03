import 'package:expertis/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class ServiceComponent extends StatefulWidget {
  Services element;
  // BMServiceListModel element;

  ServiceComponent({required this.element});

  @override
  State<ServiceComponent> createState() => _ServiceComponentState();
}

class _ServiceComponentState extends State<ServiceComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(
                title: widget.element.serviceName ?? '', size: 14, maxLines: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rs ${widget.element.price} , ${widget.element.time} min',
                  style: secondaryTextStyle(
                    color: appStore.isDarkModeOn
                        ? bmTextColorDarkMode
                        : bmPrimaryColor,
                    size: 12,
                  ),
                ),
                16.width,
                Text(
                  widget.element.time ?? '',
                  style: secondaryTextStyle(
                    color: appStore.isDarkModeOn
                        ? bmTextColorDarkMode
                        : bmPrimaryColor,
                    size: 12,
                  ),
                ),
              ],
            )
          ],
        ).expand(),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bmPrimaryColor.withAlpha(50),
                borderRadius: radius(100),
                border: Border.all(color: bmPrimaryColor),
              ),
              padding: EdgeInsets.all(6),
              child: InkWell(
                child: Icon(Icons.info, color: bmPrimaryColor),
                onTap: () {
                  // showBookBottomSheet(context, element);
                },
              ),
            ),
            8.width,
          ],
        )
      ],
    ).paddingSymmetric(vertical: 8);
  }
}
