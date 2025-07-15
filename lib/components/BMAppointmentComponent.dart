import 'package:beamer/beamer.dart';
import 'package:expertis/main.dart';
import 'package:expertis/models/appointment_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BMWidgets.dart';

class BMAppointmentComponent extends StatefulWidget {
  AppointmentModel element;

  BMAppointmentComponent({required this.element});

  @override
  _BMAppointmentComponentState createState() => _BMAppointmentComponentState();
}

class _BMAppointmentComponentState extends State<BMAppointmentComponent> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? appStore.isDarkModeOn
                ? Colors.white.withAlpha(30)
                : bmSpecialColorDark.withAlpha(30)
            : context.cardColor,
        borderRadius: radius(32),
        border: Border.all(
            color: isSelected
                ? appStore.isDarkModeOn
                    ? Colors.white
                    : bmSpecialColorDark
                : context.cardColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.network(
                      widget.element.shopId?.shopLogo ??
                          Assets.defaultShopImage,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(32),
              10.height,
              Text(widget.element.appointmentStatus ?? '',
                  style: TextStyle(
                      color: appStore.isDarkModeOn
                          ? Colors.white
                          : bmSpecialColorDark,
                      fontSize: 12)),
            ],
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleText(
                  title: widget.element.shopId?.shopName ?? '',
                  size: 16,
                  maxLines: 2),

              2.height,
              Text("${widget.element.services?.length} services",
                  style: primaryTextStyle(color: bmPrimaryColor, size: 14)),
              3.height,
              Text(
                  "from: ${DateFormat('hh:MM a EEEE dd MMMM yyyy').format(DateTime.parse(widget.element.startTime ?? ''))}",
                  style: primaryTextStyle(color: bmPrimaryColor, size: 10)),
              Text(
                  "To: ${DateFormat('hh:MM a EEEE dd MMMM yyyy').format(DateTime.parse(widget.element.endTime ?? ''))}",
                  style: primaryTextStyle(color: bmPrimaryColor, size: 10)),
              3.height,
              Text("Total Price ${widget.element.totalPrice.toString()} Rs",
                  style: primaryTextStyle(color: bmPrimaryColor, size: 14)),
              2.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timelapse, color: bmPrimaryColor, size: 16),
                  4.width,
                  Text("${widget.element.totalTime.toString()} min",
                      style: secondaryTextStyle(
                          size: 12,
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark))
                ],
              ),

              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Icon(Icons.shopping_bag_rounded,
              //         color: bmPrimaryColor, size: 14),
              //     4.width,
              //     Text(widget.element.product,
              //         style: secondaryTextStyle(
              //             size: 12,
              //             color: appStore.isDarkModeOn
              //                 ? bmTextColorDarkMode
              //                 : bmSpecialColorDark))
              //   ],
              // )
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      Beamer.of(context)
          .beamToNamed(RoutesName.viewAppointmentWithId(widget.element.id));
    });
  }
}
