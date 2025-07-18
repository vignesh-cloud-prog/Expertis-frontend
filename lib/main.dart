//region imports
import 'package:expertis/routes/admin_routes.dart';
import 'package:expertis/routes/appointment_routes.dart';
import 'package:expertis/routes/errors.routes.dart';
import 'package:expertis/routes/home_routes.dart';
import 'package:expertis/routes/more_routes.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/routes/search_routes.dart';
import 'package:expertis/routes/shop_routes.dart';
import 'package:expertis/routes/user_routes.dart';
import 'package:expertis/store/AppStore.dart';
import 'package:expertis/utils/AppTheme.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:expertis/view_model/appointment_list_view_model.dart';
import 'package:expertis/view_model/categories_view_model.dart';
// import 'package:expertis/view_model/services/firebase_dynamic_link.dart';
import 'package:expertis/view_model/shop_list_view_model.dart';
import 'package:expertis/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:beamer/beamer.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

AppStore appStore = AppStore();

int currentIndex = 0;

void main() async {
  Beamer.setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: languageList());

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  //region Entry Point

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    ).call,
    // notFoundRedirectNamed: '/books',
  );

  AppLinks? _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    // Listen for all incoming links (initial and subsequent)
    _linkSubscription = _appLinks!.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    // Map the URI to a Beamer path. This assumes your deep links match your route structure.
    final path = uri.path;
    if (path.isNotEmpty) {
      routerDelegate.beamToNamed(path, stacked: false);
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '$appName${!isMobile ? ' ${platformName()}' : ''}',
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
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
