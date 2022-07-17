import 'package:beamer/beamer.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMSingleComponentScreen.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ShopsLocation extends BeamLocation<BeamState> {
  @override
  Widget builder(BuildContext context, Widget navigator) =>
      ChangeNotifierProvider(
        create: (context) => ShopViewModel(),
        child: navigator,
      );
  @override
  List<String> get pathPatterns => ['/shops/:shopId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.uri.pathSegments.contains('shops'))
        BeamPage(
          key: ValueKey('shops'),
          title: 'Shops',
          child: BMDashboardScreen(
            flag: false,
          ),
        ),
      if (state.pathParameters.containsKey('shopId'))
        BeamPage(
          key: ValueKey('shop-${state.pathParameters['shopId']}'),
          title: 'Shop ${state.pathParameters['shopId']}',
          child: BMSingleComponentScreen(
            shopId: state.pathParameters['shopId'] ?? 'null',
          ),
        ),
    ];
  }
}
