import 'package:expertis/main.dart';
import 'package:expertis/models/review_model.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BMCommentModel.dart';
import '../utils/BMWidgets.dart';

class ReviewComponent extends StatefulWidget {
  ReviewModel? element;

  ReviewComponent({required this.element});

  @override
  _ReviewComponentState createState() => _ReviewComponentState();
}

class _ReviewComponentState extends State<ReviewComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.network(
                        widget.element?.from?.userPic != null &&
                                widget.element?.from?.userPic != "null"
                            ? widget.element!.from!.userPic
                            : Assets.defaultUserImage,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(100),
                10.width,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(
                        title: widget.element?.from?.name ?? '', size: 16),
                    Text(
                        DateFormat('dd MMM yyyy').format(DateTime.parse(
                            widget.element?.createdAt ??
                                DateTime.now().toString())),
                        style: primaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmSpecialColor)),
                  ],
                ),
              ],
            ),
            10.height,
            RatingBar(
              initialRating: widget.element?.rating.toDouble() ?? 0.0,
              minRating: 5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                //
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(widget.element?.comment ?? '',
                  overflow: TextOverflow.visible,
                  maxLines: 5,
                  style: primaryTextStyle(
                      color: appStore.isDarkModeOn
                          ? bmTextColorDarkMode
                          : bmSpecialColor)),
            ),
          ],
        )
      ],
    ).paddingOnly(left: 16, bottom: 16);
  }
}
