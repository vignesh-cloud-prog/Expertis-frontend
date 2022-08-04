import 'package:expertis/main.dart';
import 'package:expertis/models/review_model.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleText(title: widget.element?.title ?? '', size: 16),
                Text(widget.element?.from ?? '',
                    style: primaryTextStyle(
                        color: appStore.isDarkModeOn
                            ? bmTextColorDarkMode
                            : bmSpecialColor)),
                RatingBar(
                  initialRating: 5,
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
        ).expand(flex: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
        ).expand(flex: 1),
      ],
    ).paddingOnly(top: 8, bottom: 8, left: 0);
  }
}
