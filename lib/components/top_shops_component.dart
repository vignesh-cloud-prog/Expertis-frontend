import 'package:expertis/components/shop_card_home_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class BMTopShopsComponent extends StatefulWidget {
  const BMTopShopsComponent({super.key});

  @override
  State<BMTopShopsComponent> createState() => _BMTopShopsComponentState();
}

class _BMTopShopsComponentState extends State<BMTopShopsComponent> {
  ShopListViewModel shopListViewModel = ShopListViewModel();
  String defaultImage =
      "https://www.google.com/imgres?imgurl=https%3A%2F%2Ftimesofindia.indiatimes.com%2Fphoto%2F87653100.cms&imgrefurl=https%3A%2F%2Fvamaindia.in%2F2021%2F11%2F12%2Fwhats-new-in-the-beauty-industry%2F&tbnid=fwjOMT5-HyaRYM&vet=12ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg..i&docid=gSolIUjsINvNPM&w=1200&h=900&itg=1&q=beauty&ved=2ahUKEwjuuuTtyPj4AhU6KbcAHVglCkAQMygVegUIARCLAg";

  @override
  void initState() {
    shopListViewModel.fetchShopsDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopListViewModel>.value(
      value: shopListViewModel,
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
                return ShopCardHomeComponent(
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
