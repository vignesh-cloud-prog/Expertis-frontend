import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';

class WriteReviewScreen extends StatefulWidget {
  final String shopId;
  const WriteReviewScreen({Key? key, required this.shopId}) : super(key: key);
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _reviewController = TextEditingController();
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appStore.appBarColor,
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(Icons.arrow_back,
              color: appStore.isDarkModeOn ? white : black),
        ),
        actions: [
          AppButton(
            elevation: 0,
            child: Text('Post', style: boldTextStyle(color: bmPrimaryColor)),
            width: 150,
            onTap: () {
              Beamer.of(context).beamToReplacementNamed(RoutesName.login);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(title: "So What Do You Think?"),
          16.height,
          Icon(Icons.format_quote_rounded, size: 50, color: bmPrimaryColor),
          16.height,
          Text(
            'Tell us about your experience: the services, the environment, the staff, or anything , etc.',
            style: primaryTextStyle(
                color: appStore.isDarkModeOn
                    ? bmTextColorDarkMode
                    : bmSpecialColor),
          ),
          24.height,
          titleText(
            title: 'Please write atleast 50 characters',
            size: 16,
          ),
          AppTextField(
            keyboardType: TextInputType.multiline,
            autoFocus: true,
            textFieldType: TextFieldType.NAME,
            controller: _reviewController,
            cursorColor: bmPrimaryColor,
            textStyle: boldTextStyle(
                color: appStore.isDarkModeOn
                    ? bmTextColorDarkMode
                    : bmPrimaryColor),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: appStore.isDarkModeOn
                          ? bmTextColorDarkMode
                          : bmPrimaryColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: appStore.isDarkModeOn
                          ? bmTextColorDarkMode
                          : bmPrimaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: appStore.isDarkModeOn
                          ? bmTextColorDarkMode
                          : bmPrimaryColor)),
            ),
          ),
          20.height,
          titleText(
            title: 'Your overall rating:',
            size: 16,
          ),
          16.height,
          Center(
            child: RatingBar(
              initialRating: 0,
              minRating: 5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 50,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                //
              },
            ),
          ),
        ],
      ).paddingAll(20),
    );
  }
}
