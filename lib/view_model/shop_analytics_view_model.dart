import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/models/analytics_info_model.dart';
import 'package:expertis/utils/BMColors.dart';

class ShopAnalyticsViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  static Map<String, AnalyticInfo> ShopAnalyticsData = {
    'views': AnalyticInfo(
      svgSrc: 'assets/svg/user.svg',
      title: 'Views',
      count: 100,
      color: bmSpecialColor,
    ),
    'favorites': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Favorites',
      count: 100,
      color: bmPrimaryColor,
    ),
    'reviews': AnalyticInfo(
      svgSrc: 'assets/svg/task.svg',
      title: 'Reviews',
      count: 100,
      color: bmPrimaryColor,
    ),
    'services': AnalyticInfo(
      svgSrc: 'assets/svg/bug.svg',
      title: 'Services',
      count: 100,
      color: bmPrimaryColor,
    ),
    'total_appointments': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Total Appointments',
      count: 100,
      color: bmPrimaryColor,
    ),
    'completed': AnalyticInfo(
      svgSrc: 'assets/svg/task.svg',
      title: 'Completed',
      count: 100,
      color: bmPrimaryColor,
    ),
    'pending': AnalyticInfo(
      svgSrc: 'assets/svg/bug.svg',
      title: 'Pending',
      count: 100,
      color: bmPrimaryColor,
    ),
    'confirmed': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'Confirmed',
      count: 100,
      color: bmPrimaryColor,
    ),
    'cancelled': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'Canceled',
      count: 100,
      color: bmPrimaryColor,
    ),
    'rejected': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'Rejected',
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
