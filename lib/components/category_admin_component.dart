import 'package:beamer/beamer.dart';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryAdminCardComponent extends StatelessWidget {
  final CategoryModel? category;
  const CategoryAdminCardComponent({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryViewModel categoryViewModel =
        Provider.of<CategoryViewModel>(context);
    // print('category?.tagPicture: ${category?.tagPic}');
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
        imageUrl: category?.tagPic == ""
            ? Assets.defaultCategoryImage
            : category?.tagPic ?? Assets.defaultCategoryImage,
        boxFit: BoxFit.fill,
      ).paddingAll(4),
      title: Text(category?.tagName ?? ""),
      trailing: Expanded(
        child: SizedBox(
          height: size.width * 0.20,
          width: size.width * 0.20,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Beamer.of(context).beamToNamed(
                    RoutesName.updateTagWithId(category?.id),
                    data: category);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                categoryViewModel.deleteCategoryApi(category?.id, context);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
