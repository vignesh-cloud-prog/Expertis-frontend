import 'package:beamer/beamer.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMCreateShopScreen.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMSingleComponentScreen.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/screens/add_service_screen.dart';
import 'package:expertis/screens/owner_dashboard_screen.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ShopsLocation extends BeamLocation<BeamState> {
  @override
  Widget builder(BuildContext context, Widget navigator) =>
      ChangeNotifierProvider<ShopViewModel>.value(
        value: ShopViewModel(),
        child: navigator,
      );
  @override
  List<String> get pathPatterns => [
        RoutesName.allShops,
        RoutesName.viewShop,
        RoutesName.createShop,
        RoutesName.updateShop,
        RoutesName.createService,
        RoutesName.updateService,
        RoutesName.createTag,
        RoutesName.updateTag,
        RoutesName.ownerDashboard,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      // ...HomeLocation().buildPages(context, state),
      if (state.uri.pathSegments.contains('shops'))
        BeamPage(
          key: ValueKey('shops'),
          title: 'Shops',
          child: BMDashboardScreen(),
        ),
      if (state.uri.pathSegments.contains('create'))
        const BeamPage(
          key: ValueKey('create_shop'),
          title: 'Create Shop',
          child: BMCreateShopScreen(),
        ),
      if (state.pathParameters.containsKey('shopId'))
        BeamPage(
          key: ValueKey('shop-${state.pathParameters['shopId']}'),
          title: '${state.pathParameters['shopId']}',
          child: BMSingleComponentScreen(
            shopId: state.pathParameters['shopId'] ?? 'null',
          ),
        ),

      if (state.uri.pathSegments.contains('service') &&
          state.uri.pathSegments.contains('add'))
        const BeamPage(
          key: ValueKey(RoutesName.createService),
          title: 'Add Service',
          child: CreateServiceScreen(),
        ),
      if (state.uri.pathSegments.contains('dashboard'))
        BeamPage(
          key: ValueKey(RoutesName.createService),
          title: 'Dashboard',
          child: ShopOwnerDashboardScreen(),
        ),

      if (state.pathParameters.containsKey('serviceId') &&
          state.uri.pathSegments.contains('update'))
        BeamPage(
          key: ValueKey('Update ${state.pathParameters['serviceId']}'),
          title: 'Update ${state.pathParameters['serviceId']}',
          child: BMSingleComponentScreen(
            shopId: state.pathParameters['serviceId'] ?? 'null',
          ),
        ),
    ];
  }
}
