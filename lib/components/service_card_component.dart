import 'package:beamer/beamer.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:store_api_flutter_course/consts/global_colors.dart';

class ServiceCardComponent extends StatelessWidget {
  final Services? element;
  const ServiceCardComponent({super.key, required this.element});
  @override
  Widget build(BuildContext context) {
    print(" service element: ${element?.toJson()}");
    ShopViewModel shopViewModel = Provider.of<ShopViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: Image.asset('assets/image-not-found.jpg',
            fit: BoxFit.cover,
            width: size.width * 0.15,
            height: size.width * 0.15),
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
            icon: const Icon(Icons.edit),
            onPressed: () {
              Beamer.of(context).beamToNamed(
                  RoutesName.updateServiceWithId(element?.id),
                  data: element);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              shopViewModel.deleteServiceApi(element?.id, context);
            },
          ),
        ]),
      ),
    );
  }
}
