//region imports
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/routes/admin_routes.dart';
import 'package:expertis/routes/appointment_routes.dart';
import 'package:expertis/routes/errors.routes.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/routes/more_routes.dart';
import 'package:expertis/routes/search_routes.dart';
import 'package:expertis/routes/shop_routes.dart';
import 'package:expertis/routes/user_routes.dart';
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/store/AppStore.dart';
import 'package:expertis/utils/AppTheme.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/categories_view_model.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:beamer/beamer.dart';
import 'package:url_strategy/url_strategy.dart';

AppStore appStore = AppStore();

int currentIndex = 0;

void main() async {
  //region Entry Point
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => ShopListViewModel()),
      ChangeNotifierProvider(create: (_) => ShopViewModel()),
      ChangeNotifierProvider(create: (_) => CategoryViewModel()),
      ChangeNotifierProvider(create: (_) => AppointmentListViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerDelegate(
      initialPath: RoutesName.splash,
      locationBuilder: BeamerLocationBuilder(
        beamLocations: [
          HomeLocation(),
          ShopsLocation(),
          ErrorsLocation(),
          UserLocation(),
          AppointmentLocation(),
          MoreLocation(),
          SearchLocation(),
          AdminLocation(),
        ],
      ),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '$appName${!isMobile ? ' ${platformName()}' : ''}',
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      // initialRoute: RoutesName.splash,
      theme: !appStore.isDarkModeOn
          ? AppThemeData.lightTheme
          : AppThemeData.darkTheme,
      // navigatorKey: navigatorKey,
      scrollBehavior: SBehavior(),
      // supportedLocales: LanguageDataModel.languageLocales(),
      // onGenerateRoute: (settings) => generateRoute(settings),
      // localeResolutionCallback: (locale, supportedLocales) => locale,
    );
  }
}
