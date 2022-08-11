import 'package:expertis/components/shop_card_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminShopsHomeScreen extends StatefulWidget {
  AdminShopsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminShopsHomeScreen> createState() => _AdminShopsHomeScreenState();
}

class _AdminShopsHomeScreenState extends State<AdminShopsHomeScreen> {
  final shopListViewModel = ShopListViewModel();
  @override
  void initState() {
    shopListViewModel.fetchShopsDataApi(); //widget.shopId

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChangeNotifierProvider<ShopListViewModel>.value(
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
                    List<ShopModel>? shopList = value.shopList.data?.shops;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: shopList?.length,
                        itemBuilder: (ctx, index) {
                          return ShopCardComponent(element: shopList![index]);
                        });
                  default:
                    return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
