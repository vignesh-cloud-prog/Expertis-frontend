import 'package:expertis/components/shop_contact_component.dart';
import 'package:expertis/components/shop_members_component.dart';
import 'package:expertis/components/shop_info_component.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/utils/BMWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutShopComponent extends StatelessWidget {
  final ShopModel? shop;
  const AboutShopComponent({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ShopInfoComponent(shop: shop),
        25.height,
        titleText(title: "Shop Members"),
        ShopMembersComponent(members: shop?.members),
        titleText(title: "Contact"),
        ShopContactComponent(contact: shop?.contact),
      ]).paddingAll(16),
    );
  }
}
