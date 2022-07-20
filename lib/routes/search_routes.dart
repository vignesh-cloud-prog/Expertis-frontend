import 'package:beamer/beamer.dart';
import 'package:expertis/fragments/BMMoreFragment.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMDashboardScreen.dart';
import 'package:flutter/cupertino.dart';

class SearchLocation extends BeamLocation<BeamState> {
  // @override
  // Widget builder(BuildContext context, Widget navigator) =>
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: navigator,
  //     );
  @override
  List<String> get pathPatterns => [
        RoutesName.search,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: ValueKey(RoutesName.search),
          title: 'Search',
          child: BMDashboardScreen(),
          type: BeamPageType.slideTransition),
    ];
  }
}
