import 'package:expertis/components/BMCommonCardComponent.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../screens/BMTopOffersScreen.dart';

class BMTopShopsComponent extends StatefulWidget {
  const BMTopShopsComponent({super.key});

  @override
  State<BMTopShopsComponent> createState() => _BMTopShopsComponentState();
}

class _BMTopShopsComponentState extends State<BMTopShopsComponent> {
  ShopListViewModel shopViewModel = ShopListViewModel();
  String defaultImage =
      "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftimesofindia.indiatimes.com%2Fphoto%2F87653100.cms&imgrefurl=https%3A%2F%2Fvamaindia.in%2F2021%2F11%2F12%2Fwhats-new-in-the-beauty-industry%2F&tbnid=fwjOMT5-HyaRYM&vet=12ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg..i&docid=gSolIUjsINvNPM&w=1200&h=900&itg=1&q=beauty&ved=2ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg";

  @override
  void initState() {
    shopViewModel.fetchShopsDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopListViewModel>(
      create: (BuildContext context) => shopViewModel,
      child: Consumer<ShopListViewModel>(builder: (context, value, _) {
        switch (value.shopList.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
              child: Text(value.shopList.message.toString()),
            );
          case Status.COMPLETED:
            return HorizontalList(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              spacing: 16,
              itemCount: value.shopList.data!.shops!.length,
              itemBuilder: (context, index) {
                return BMCommonCardComponent(
                    element: value.shopList.data!.shops![index],
                    fullScreenComponent: false,
                    isFavList: false);
              },
            );
          default:
            return Container();
        }
      }),
    );
  }
}
