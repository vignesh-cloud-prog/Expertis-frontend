import 'package:expertis/main.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:expertis/utils/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/BMCommentModel.dart';
import '../utils/BMWidgets.dart';

class ReviewComponent extends StatefulWidget {
  BMCommentModel element;

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
            Image.asset(widget.element.image,
                    height: 40, width: 40, fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(100),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleText(title: widget.element.message, size: 16),
                Text(widget.element.name,
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
                  child: Text(
                      'lorem ipsum djkflj  dkfgkjdf  kdjkfl   dfkjgk dfg k kl dkfg  kdfgl ldkf  ldkfg k  dfkl kdf k kdf  kdf lk kd gk  kkldfgkld fk k fgj fdk  ',
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
          children: [
            widget.element.isLiked
                ? Icon(Icons.favorite, color: Colors.amber).onTap(() {
                    widget.element.isLiked = !widget.element.isLiked;
                    setState(() {});
                  })
                : Icon(Icons.favorite_outline, color: bmPrimaryColor).onTap(() {
                    widget.element.isLiked = !widget.element.isLiked;
                    setState(() {});
                  }),
            Text(widget.element.likes,
                style: secondaryTextStyle(color: bmPrimaryColor))
          ],
        ).expand(flex: 1),
      ],
    ).paddingOnly(top: 8, bottom: 8, left: 0);
  }
}
