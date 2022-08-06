import 'package:expertis/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class ShopContactComponent extends StatelessWidget {
  final Contact? contact;
  const ShopContactComponent({Key? key, required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.call),
            10.width,
            Text(contact?.phone.toString() ?? ""),
          ],
        ).paddingAll(8),
        Row(
          children: [
            Icon(Icons.email),
            10.width,
            Text(contact?.email ?? ""),
          ],
        ).paddingAll(8),
        if (contact?.whatsapp != null)
          Row(
            children: [
              Icon(Icons.whatsapp),
              10.width,
              Text(contact?.whatsapp ?? ""),
            ],
          ).paddingAll(8),
        if (contact?.website != null)
          Row(
            children: [
              Icon(Icons.web),
              10.width,
              Text(contact?.website ?? ""),
            ],
          ).paddingAll(8),
        if (contact?.facebook != null)
          Row(
            children: [
              Icon(Icons.facebook),
              10.width,
              Text(contact?.facebook ?? ""),
            ],
          ).paddingAll(8),
        if (contact?.instagram != null)
          Row(
            children: [
              Icon(
                FeatherIcons.instagram,
              ),
              10.width,
              Text(contact?.instagram ?? ""),
            ],
          ).paddingAll(8),
        if (contact?.twitter != null)
          Row(
            children: [
              Icon(FeatherIcons.twitter),
              10.width,
              Text(contact?.twitter ?? ""),
            ],
          ).paddingAll(8),
        Row(
          children: [
            Icon(Icons.location_on),
            10.width,
            Text('${contact?.address} \n${contact?.pinCode}'),
          ],
        ).paddingAll(8),
      ],
    ).paddingAll(8);
  }
}
