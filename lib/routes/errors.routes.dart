import 'package:beamer/beamer.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/screens/BMNoInternetScreen.dart';
import 'package:expertis/screens/BMSomethingWentWrongScreen.dart';
import 'package:expertis/view/screens/app/exceptions/token_expired_screen.dart';
import 'package:flutter/cupertino.dart';

class ErrorsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        RoutesName.unKnownError,
        RoutesName.tokenExpired,
        RoutesName.noConnection
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('error'),
        title: 'Error',
        child: BMErrorScreen(),
      ),
      if (state.pathPatternSegments.contains("token-expired"))
        const BeamPage(
            key: ValueKey('error-${RoutesName.tokenExpired}'),
            title: 'Token Expired Login again',
            child: BMTokenExpiredScreen()),
      if (state.pathPatternSegments.contains("no-internet"))
        const BeamPage(
            key: ValueKey('error-${RoutesName.noConnection}'),
            title: 'No Connection',
            child: BMNoInternetScreen()),
    ];
  }
}
