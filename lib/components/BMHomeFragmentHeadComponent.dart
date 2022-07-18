import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class HomeFragmentHeadComponent extends StatelessWidget {
  const HomeFragmentHeadComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: 250.0,
        padding: EdgeInsets.only(bottom: 50.0),
        decoration: BoxDecoration(
          color: kYellow,
          image: DecorationImage(
            image: AssetImage("assets/img-1639.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.black12.withOpacity(.0),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text("Expertis",
                  style: boldTextStyle(size: 30, color: white)),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: radius(100)),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.notifications_none,
                      color: bmSpecialColorDark,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Find and book best services",
                style: kTitleStyle.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: double.infinity,
              height: 50.0,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white.withOpacity(.9),
              ),
              child: TextField(
                cursorColor: kBlack,
                decoration: InputDecoration(
                  hintText: "Search Saloon, Spa and Barber",
                  hintStyle: kHintStyle,
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: kGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
