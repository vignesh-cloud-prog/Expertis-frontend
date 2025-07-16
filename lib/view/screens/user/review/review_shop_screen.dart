import 'package:expertis/models/review_model.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';
import 'package:expertis/view_model/review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';

class WriteReviewScreen extends StatefulWidget {
  String? shopId;
  ReviewModel? review = ReviewModel();
  WriteReviewScreen({super.key, this.shopId, this.review});
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
    widget.review ??= ReviewModel();
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ReviewViewModel reviewViewModel = ReviewViewModel();
    print('review ${widget.review?.toJson()}');
    print('title of review ${widget.review?.title}');

    // final _formKey = GlobalKey<FormState>();
    // TextEditingController _reviewController = TextEditingController();
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
            width: 150,
            onTap: () {
              widget.review?.to = widget.shopId;
              widget.review?.modelType = "Shop";
              var reviewData = widget.review?.toJson()
                ?..removeWhere((key, value) =>
                    value == null ||
                    value == '' ||
                    value == 'null' ||
                    value == []);

              Map<String, String> data =
                  reviewData!.map((k, v) => MapEntry(k, v.toString()));

              Map<String, dynamic> files = {
                'reviewPhotos': widget.review?.reviewPhotos,
              };
              reviewViewModel.addOrUpdateReviewData(
                  false, data, false, files, context);
            },
            child: Text(widget.review?.rating == null ? 'Post' : 'Save',
                style: boldTextStyle(color: bmPrimaryColor)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText(title: "So What Do You Think?", color: bmPrimaryColor),
            16.height,
            const Icon(Icons.format_quote_rounded, size: 50, color: bmPrimaryColor),
            16.height,
            // titleText(
            //   title: 'Title',
            //   size: 16,
            // ),
            // AppTextField(
            //   keyboardType: TextInputType.text,
            //   // nextFocus: shopId,
            //   initialValue: widget.review?.title ?? '',
            //   onChanged: (value) {
            //     widget.review?.title = value;
            //   },
            //   textFieldType: TextFieldType.NAME,
            //   errorThisFieldRequired: 'Title is required',
            //   autoFocus: true,
            //   cursorColor: bmPrimaryColor,
            //   textStyle: boldTextStyle(
            //       color: appStore.isDarkModeOn
            //           ? bmTextColorDarkMode
            //           : bmPrimaryColor),
            //   decoration: InputDecoration(
            //     border: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //     focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(
            //             color: appStore.isDarkModeOn
            //                 ? bmTextColorDarkMode
            //                 : bmPrimaryColor)),
            //   ),
            // ),
            // 16.height,
            // Text(
            //   'Tell us about your experience: the services, the environment, the staff, or anything , etc.',
            //   style: primaryTextStyle(
            //       color: appStore.isDarkModeOn
            //           ? bmTextColorDarkMode
            //           : bmSpecialColor),
            // ),
            24.height,
            titleText(
              title: 'Please write atleast 50 characters',
              size: 16,
            ),
            AppTextField(
              keyboardType: TextInputType.multiline,
              initialValue: widget.review?.comment ?? '',
              onChanged: (value) {
                widget.review?.comment = value;
              },
              autoFocus: true,
              textFieldType: TextFieldType.NAME,
              // controller: _reviewController,
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
                initialRating: widget.review?.rating != null
                    ? widget.review?.rating.toDouble()
                    : 0,
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
                  widget.review?.rating = rating.toString();
                },
              ),
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
