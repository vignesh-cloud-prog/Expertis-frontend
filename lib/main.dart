//region imports
import 'package:expertis/screens/BMSplashScreen.dart';
import 'package:expertis/store/AppStore.dart';
import 'package:expertis/utils/AppTheme.dart';
import 'package:expertis/utils/BMConstants.dart';
import 'package:expertis/utils/BMDataGenerator.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:expertis/routes.dart';
import 'package:expertis/view_model/auth_view_model.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

AppStore appStore = AppStore();

int currentIndex = 0;

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel())
    ],
    child: const MyApp(),
  ));
  //endregion
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '$appName${!isMobile ? ' ${platformName()}' : ''}',
        initialRoute: RoutesName.splash,
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        onGenerateRoute: (settings) => generateRoute(settings),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
