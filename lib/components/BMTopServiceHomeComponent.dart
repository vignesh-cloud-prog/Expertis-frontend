import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../screens/BMTopOffersScreen.dart';

class BMTopServiceHomeComponent extends StatefulWidget {
  const BMTopServiceHomeComponent({super.key});

  @override
  State<BMTopServiceHomeComponent> createState() =>
      _BMTopServiceHomeComponentState();
}

class _BMTopServiceHomeComponentState extends State<BMTopServiceHomeComponent> {
  CategoryViewModel categoryViewModel = CategoryViewModel();
  String defaultImage =
      "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftimesofindia.indiatimes.com%2Fphoto%2F87653100.cms&imgrefurl=https%3A%2F%2Fvamaindia.in%2F2021%2F11%2F12%2Fwhats-new-in-the-beauty-industry%2F&tbnid=fwjOMT5-HyaRYM&vet=12ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg..i&docid=gSolIUjsINvNPM&w=1200&h=900&itg=1&q=beauty&ved=2ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg";

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
                            value.categoryList.data!.categories![index]
                                    .tagPic ??
                                defaultImage,
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
