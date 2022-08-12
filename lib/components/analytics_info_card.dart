import 'package:expertis/models/analytics_info_model.dart';
import 'package:expertis/utils/BMColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({Key? key, required this.info}) : super(key: key);

  final AnalyticInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16 / 2,
      ),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.count}",
                style: TextStyle(
                  color: bmSpecialColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16 / 2),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: info.color!.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(Icons.verified_user)
                  // child: SvgPicture.asset(
                  //   info.svgSrc!,
                  //   color: info.color,
                  // ),
                  )
            ],
          ),
          Text(
            info.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: bmPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
