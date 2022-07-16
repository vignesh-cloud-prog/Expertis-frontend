import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/screens/BMChangePasswordScreen.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:expertis/screens/BMForgetPasswordScreen.dart';
import 'package:expertis/screens/BMLoginNowScreen.dart';
import 'package:expertis/screens/BMLoginScreen.dart';
import 'package:expertis/screens/BMNoInternetScreen.dart';
import 'package:expertis/screens/BMRegisterScreen.dart';
import 'package:expertis/screens/BMSingleComponentScreen.dart';
import 'package:expertis/screens/BMSomethingWentWrongScreen.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/screens/BMTokenExpiredScreen.dart';
import 'package:expertis/screens/BMUserProfileEdit.dart';
import 'package:expertis/screens/BMWalkThroughScreen.dart';
import 'package:expertis/screens/BMVerifyOTPScreen.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments;
  switch (routeSettings.name) {
    case BMSplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMSplashScreen(),
      );
    case BMWalkThroughScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMWalkThroughScreen(),
      );
    case BMRegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMRegisterScreen(),
      );
    case BMLoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMLoginScreen(),
      );
    case BMForgetPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMForgetPasswordScreen(),
      );
    case BMChangePasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMChangePasswordScreen(),
      );
    case BMLoginNowScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BMLoginNowScreen(),
      );
    case BMVerifyOTPScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMVerifyOTPScreen(),
      );
    case BMDashboardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMDashboardScreen(
          flag: false,
        ),
      );
    case BMTokenExpiredScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMTokenExpiredScreen(),
      );
    case RoutesName.createProfile:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMUserProfileEditScreen(
          title: "Create Profile",
          buttonName: "Create",
        ),
      );
    case RoutesName.editProfile:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMUserProfileEditScreen(),
      );
    case RoutesName.noConnection:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMNoInternetScreen(),
      );
    case RoutesName.somethingWentWrong:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMSomethingWentWrongScreen(),
      );
    case "shop/details":
      ShopModel shop = args as ShopModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BMSingleComponentScreen(
          element: shop,
        ),
      );

    // case CategoryDealsScreen.routeName:
    //   var category = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => CategoryDealsScreen(
    //       category: category,
    //     ),
    //   );
    // case SearchScreen.routeName:
    //   var searchQuery = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchScreen(
    //       searchQuery: searchQuery,
    //     ),
    //   );
    // case ProductDetailScreen.routeName:
    //   var product = routeSettings.arguments as Product;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ProductDetailScreen(
    //       product: product,
    //     ),
    //   );
    // case AddressScreen.routeName:
    //   var totalAmount = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => AddressScreen(
    //       totalAmount: totalAmount,
    //     ),
    //   );
    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as Order;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
