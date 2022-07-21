import 'dart:developer';

import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../models/BMServiceListModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMAvailabilityComponent extends StatefulWidget {
  List<Services>? element;

  BMAvailabilityComponent({required this.element});

  @override
  _BMAvailabilityComponentState createState() =>
      _BMAvailabilityComponentState();
}

class _BMAvailabilityComponentState extends State<BMAvailabilityComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.element
                ?.map((e) => Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            titleText(
                                title: e.serviceName ?? '',
                                size: 16,
                                maxLines: 1),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('by',
                                    style: secondaryTextStyle(
                                        color: bmPrimaryColor, size: 12)),
                                4.width,
                                Image.asset('images/face_one.png',
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover)
                                    .cornerRadiusWithClipRRect(100),
                                4.width,
                                Text('Arthur Brady',
                                    style: primaryTextStyle(
                                        color: appStore.isDarkModeOn
                                            ? Colors.white
                                            : bmSpecialColorDark))
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                titleText(
                                    title: e.price?.toString() ?? ' ',
                                    size: 16),
                                Text(e.time ?? ' ',
                                    style: secondaryTextStyle(
                                        color: bmPrimaryColor, size: 14))
                              ],
                            ),
                            10.width,
                          ],
                        )
                      ],
                    ))
                .toList() ??
            [Center(child: Text('No services selected'))]);
  }
}
