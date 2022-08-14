import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/models/analytics_info_model.dart';
import 'package:expertis/utils/BMColors.dart';

class AdminAnalyticsViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  static Map<String, AnalyticInfo> adminAnalyticsData = {
    'total_users': AnalyticInfo(
      svgSrc: 'assets/svg/user.svg',
      title: 'Users',
      count: 100,
      color: bmSpecialColor,
    ),
    'total_shops': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Shops',
      count: 100,
      color: bmPrimaryColor,
    ),
    'total_services': AnalyticInfo(
      svgSrc: 'assets/svg/task.svg',
      title: 'Services',
      count: 100,
      color: bmPrimaryColor,
    ),
    'total_categories': AnalyticInfo(
      svgSrc: 'assets/svg/bug.svg',
      title: 'Categories',
      count: 100,
      color: bmPrimaryColor,
    ),
    'total_appointments': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'Appointments',
      count: 100,
      color: bmPrimaryColor,
    ),
  };

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
