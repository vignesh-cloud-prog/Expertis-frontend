import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CategoryHomeComponent extends StatefulWidget {
  const CategoryHomeComponent({super.key});

  @override
  State<CategoryHomeComponent> createState() => _CategoryHomeComponentState();
}

class _CategoryHomeComponentState extends State<CategoryHomeComponent> {
  CategoryViewModel categoryViewModel = CategoryViewModel();

  @override
  void initState() {
    categoryViewModel.fetchCategoryListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryViewModel>.value(
      value: categoryViewModel,
      child: Consumer<CategoryViewModel>(builder: (context, value, _) {
        switch (value.categoryList.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(child: Text(value.categoryList.message.toString()));
          case Status.COMPLETED:
            return HorizontalList(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                spacing: 16,
                itemCount: value.categoryList.data!.categories!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: context.cardColor, borderRadius: radius(32)),
                        child: Image.network(
                          value.categoryList.data?.categories![index].tagPic ==
                                  ""
                              ? Assets.defaultCategoryImage
                              : value.categoryList.data?.categories![index]
                                      .tagPic ??
                                  Assets.defaultCategoryImage,
                          height: 36,
                          width: 36,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/image-not-found.jpg',
                                  fit: BoxFit.cover, height: 36, width: 36),
                        ),
                      ).onTap(() {
                        Beamer.of(context).beamToNamed(RoutesName.viewAllShops);
                      }),
                      8.height,
                      Text(
                          value.categoryList.data!.categories![index].tagName ??
                              '',
                          style: boldTextStyle(size: 14)),
                    ],
                  );
                });
          default:
            return Container();
        }
      }),
    );
  }
}
