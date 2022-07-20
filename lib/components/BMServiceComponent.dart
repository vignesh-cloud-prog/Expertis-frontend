import 'package:expertis/models/shop_list_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../models/BMServiceListModel.dart';
import '../utils/BMBottomSheet.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMServiceComponent extends StatefulWidget {
  Services element;
  // BMServiceListModel element;

  BMServiceComponent({required this.element});

  @override
  State<BMServiceComponent> createState() => _BMServiceComponentState();
}

class _BMServiceComponentState extends State<BMServiceComponent> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return bmPrimaryColor;
    }

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
                  '${widget.element.price}+',
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
            Checkbox(
              value: true,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              onChanged: (value) {},
            ),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 8);
  }
}
