import 'package:beamer/beamer.dart';
import 'package:expertis/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'BMColors.dart';

AppBar appBar(BuildContext context, String title,
    {List<Widget>? actions,
    bool showBack = true,
    Color? color,
    Color? iconColor,
    Color? textColor,
    String? subtitle}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: color ?? appStore.appBarColor,
    leading: showBack
        ? IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            icon: Icon(Icons.arrow_back,
                color: appStore.isDarkModeOn ? white : black),
          )
        : null,
    title: appBarTitleWidget(context, title,
        textColor: textColor, color: color, subtitle: subtitle),
    actions: actions,
    elevation: 0.5,
  );
}

Widget appBarTitleWidget(context, String title,
    {Color? color, Color? textColor, String? subtitle}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    color: color ?? appStore.appBarColor,
    child: Row(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: boldTextStyle(
                      color: color ?? appStore.textPrimaryColor, size: 20),
                  maxLines: 1,
                ),
              ),
              subtitle != null
                  ? Text(
                      subtitle,
                      style: secondaryTextStyle(
                          color: color ?? appStore.textSecondaryColor,
                          size: 14),
                      maxLines: 1,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: bmBlueColor),
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}

Widget upperContainer(
    {required Widget child, required BuildContext screenContext}) {
  return Container(
    color: appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor,
    width: screenContext.width(),
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: bmSpecialColor, borderRadius: radiusOnly(bottomLeft: 40)),
      child: child,
    ),
  );
}

Widget lowerContainer(
    {required Widget child, required BuildContext screenContext}) {
  return Container(
    color: bmSpecialColor,
    width: screenContext.width(),
    child: Container(
      decoration: BoxDecoration(
        color: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        borderRadius: radiusOnly(topRight: 40),
      ),
      child: child,
    ),
  );
}

Widget headerText({required String title, Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      50.height,
      Text(title, style: boldTextStyle(size: 30, color: color ?? white)),
      16.height,
    ],
  );
}

Widget titleText({required String title, int? size, int? maxLines}) {
  return Text(
    title,
    style: boldTextStyle(
        size: size != null ? size : 20,
        color: appStore.isDarkModeOn ? greenColor : bmSpecialColorDark),
    maxLines: maxLines != null ? maxLines : 1,
    overflow: TextOverflow.ellipsis,
  );
}

class SettingContainerWidget extends StatelessWidget {
  final Widget child;

  SettingContainerWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 2 - 24,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: radius(defaultRadius),
        border: Border.all(color: context.dividerColor, width: 2),
      ),
      child: child,
    );
  }
}
