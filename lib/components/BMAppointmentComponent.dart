import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BMAppointmentModel.dart';
import '../utils/BMWidgets.dart';

class BMAppointmentComponent extends StatefulWidget {
  BMAppointmentModel element;

  BMAppointmentComponent({required this.element});

  @override
  _BMAppointmentComponentState createState() => _BMAppointmentComponentState();
}

class _BMAppointmentComponentState extends State<BMAppointmentComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.element.isSelected
            ? appStore.isDarkModeOn
                ? Colors.white.withAlpha(30)
                : bmSpecialColorDark.withAlpha(30)
            : context.cardColor,
        borderRadius: radius(32),
        border: Border.all(
            color: widget.element.isSelected
                ? appStore.isDarkModeOn
                    ? Colors.white
                    : bmSpecialColorDark
                : context.cardColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.element.image,
                  height: 50, width: 50, fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(32),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.element.salonName,
                  style: primaryTextStyle(color: bmPrimaryColor, size: 14)),
              2.height,
              titleText(title: widget.element.service, size: 16, maxLines: 2),
              2.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timelapse, color: bmPrimaryColor, size: 16),
                  4.width,
                  Text(widget.element.time,
                      style: secondaryTextStyle(
                          size: 12,
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_rounded,
                      color: bmPrimaryColor, size: 14),
                  4.width,
                  Text(widget.element.product,
                      style: secondaryTextStyle(
                          size: 12,
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark))
                ],
              )
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      widget.element.isSelected = !widget.element.isSelected;
      setState(() {});
    });
  }
}