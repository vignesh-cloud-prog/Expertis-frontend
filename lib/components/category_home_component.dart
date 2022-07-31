import 'package:expertis/data/response/status.dart';
import 'package:expertis/utils/assets.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../screens/BMTopOffersScreen.dart';

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
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (BuildContext context) => categoryViewModel,
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
                            value.categoryList.data?.categories![index]
                                        .tagPic ==
                                    ""
                                ? Assets.defaultCategoryImage
                                : value.categoryList.data?.categories![index]
                                        .tagPic ??
                                    Assets.defaultCategoryImage,
                            height: 36),
                      ).onTap(() {
                        const BMTopOffersScreen().launch(context);
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
