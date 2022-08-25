import 'package:beamer/beamer.dart';
import 'package:expertis/components/shop_card_home_component.dart';
import 'package:expertis/data/response/status.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../components/BMFloatingActionComponent.dart';
import '../../../../main.dart';
import '../../../../utils/BMColors.dart';
import '../../../../utils/BMWidgets.dart';

class ViewAllShopsScreen extends StatefulWidget {
  const ViewAllShopsScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllShopsScreen> createState() => _ViewAllShopsScreenState();
}

class _ViewAllShopsScreenState extends State<ViewAllShopsScreen> {
  ShopListViewModel shopListViewModel = ShopListViewModel();

  @override
  void initState() {
    shopListViewModel.fetchShopsDataApi();
    (appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(bmSpecialColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: bmPrimaryColor),
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
        title: titleText(title: 'All Shops'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp, size: 30, color: bmPrimaryColor),
            onPressed: () {},
          ),
          8.width,
        ],
      ),
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
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return ShopCardHomeComponent(
                                  element: shopList![index],
                                  fullScreenComponent: true,
                                  isFavList: false)
                              .paddingAll(16);
                        });
                  default:
                    return Container();
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: BMFloatingActionComponent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
