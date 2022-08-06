import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:store_api_flutter_course/consts/global_colors.dart';

class ServiceCardComponent extends StatelessWidget {
  final Services? element;
  const ServiceCardComponent({Key? key, required this.element})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          Icons.dangerous,
          color: Colors.red,
          size: 28,
        ),
        imageUrl: element?.photo ?? Assets.defaultServiceImage,
        boxFit: BoxFit.fill,
      ),
      title: Text(element?.serviceName ?? ""),
      subtitle: Text('Rs ${element?.price.toString()}, ${element?.time} min'),
      trailing: SizedBox(
        height: size.width * 0.25,
        width: size.width * 0.25,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Beamer.of(context).beamToNamed(
                  RoutesName.updateServiceWithId(element?.id),
                  data: element);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              shopViewModel.deleteServiceApi(element?.id, context);
            },
          ),
        ]),
      ),
    );
  }
}
