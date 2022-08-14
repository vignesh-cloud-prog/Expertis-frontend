import 'package:beamer/beamer.dart';
import 'package:expertis/fragments/user_more_component.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/view/screens/user/home/user_home_screen.dart';
import 'package:flutter/cupertino.dart';

class MoreLocation extends BeamLocation<BeamState> {
  // @override
  // Widget builder(BuildContext context, Widget navigator) =>
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: navigator,
  //     );
  @override
  List<String> get pathPatterns => [
        RoutesName.more,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: ValueKey(RoutesName.more),
          title: 'More',
          child: UserHomeScreen(),
          type: BeamPageType.slideTransition),
    ];
  }
}
