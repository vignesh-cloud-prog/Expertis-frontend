import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../models/BMServiceListModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'BMShoppingScreen.dart';

class BMCalenderScreen extends StatefulWidget {
  BMServiceListModel? element =
      BMServiceListModel(name: "haircut", cost: "100", time: "20");
  bool isStaffBooking = false;

  // BMCalenderScreen({this.element,  this.isStaffBooking=false});
  BMCalenderScreen({super.key});

  @override
  _BMCalenderScreenState createState() => _BMCalenderScreenState();
}

class _BMCalenderScreenState extends State<BMCalenderScreen> {
  List<BMServiceListModel> availabilityList = [];

  int selectedTimer = 0;

  List<String> availableTimes = ['14:30', '15:00', '16:00'];

  List<String> timers = [
    'Anytime',
    'Morning',
    'Afternoon',
    'Evening',
    'Special time'
  ];

  String getYear() {
    return DateFormat.yMMM().format(DateTime.now());
  }

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  Widget bookAppointment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title: 'Availability'),
        16.height,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: availableTimes.map((e) {
            int index = availableTimes.indexOf(e);
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedTimer == index
                    ? bmPrimaryColor
                    : bmPrimaryColor.withAlpha(50),
                borderRadius: radius(32),
                border: Border.all(color: bmPrimaryColor),
              ),
              child: Text(e,
                  style: primaryTextStyle(
                      color: selectedTimer == index
                          ? Colors.white
                          : appStore.isDarkModeOn
                              ? Colors.white
                              : bmSpecialColorDark)),
            ).onTap(() {
              selectedTimer = index;
              setState(() {});
            });
          }).toList(),
        ),
        16.height,
        const Divider(),
        16.height,
        // BMAvailabilityComponent(element: widget.element!),
        16.height,
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bmPrimaryColor.withAlpha(50),
            borderRadius: radius(32),
            border: Border.all(color: bmPrimaryColor),
          ),
          child: Text(' + Add another Services',
              style: primaryTextStyle(
                  color: appStore.isDarkModeOn
                      ? Colors.white
                      : bmSpecialColorDark)),
        ).onTap(() {
          finish(context);
          finish(context);
        }),
      ],
    );
  }

  Widget bookStaff() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title: 'Timers'),
        16.height,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: timers.map((e) {
            int index = timers.indexOf(e);
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedTimer == index
                    ? bmPrimaryColor
                    : bmPrimaryColor.withAlpha(50),
                borderRadius: radius(32),
                border: Border.all(color: bmPrimaryColor),
              ),
              child: Text(e,
                  style: primaryTextStyle(
                      color: selectedTimer == index
                          ? Colors.white
                          : appStore.isDarkModeOn
                              ? Colors.white
                              : bmSpecialColorDark)),
            ).onTap(() {
              selectedTimer = index;
              setState(() {});
            });
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BMServiceListModel ele =
        BMServiceListModel(name: "vignesh", cost: "100", time: "10");
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        // title: titleText(title: getYear()),
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        elevation: 0,
        leadingWidth: 30,
        iconTheme: const IconThemeData(color: bmPrimaryColor),
      ),
      body: Column(
        children: [
          bookAppointment(),
          bookStaff(),
        ],
      ),
      floatingActionButton: !widget.isStaffBooking
          ? Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: bmPrimaryColor, borderRadius: radius(32)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Go to Store',
                      style: boldTextStyle(color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        BMShoppingScreen(isOrders: false).launch(context);
                      },
                      icon: const Icon(Icons.arrow_forward, color: Colors.white)),
                ],
              ),
            )
          : AppButton(
              width: context.width() - 32,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              padding: const EdgeInsets.all(16),
              color: bmPrimaryColor,
              onTap: () {
                finish(context);
              },
              child:
                  Text('Book Now', style: boldTextStyle(color: Colors.white)),
            ),
    );
  }
}
