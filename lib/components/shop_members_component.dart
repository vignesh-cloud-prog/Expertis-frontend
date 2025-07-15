import 'package:expertis/models/shop_model.dart';
import 'package:expertis/utils/assets.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopMembersComponent extends StatelessWidget {
  final List<Members>? members;
  const ShopMembersComponent({Key? key, required this.members})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: members?.map((e) => Member(e)).toList() ?? [],
      ),
    );
  }

  Widget Member(Members member) {
    return Container(
      child: Row(children: [
        FancyShimmerImage(
          imageUrl: member.pic ?? Assets.defaultUserImage,
          height: 30,
          width: 30,
        ),
        10.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.name ?? "",
              style: primaryTextStyle(),
            ),
            Text(member.role ?? "", style: boldTextStyle()),
          ],
        )
      ]).paddingAll(16),
    );
  }
}
