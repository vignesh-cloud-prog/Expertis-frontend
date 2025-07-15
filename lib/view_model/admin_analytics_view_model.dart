import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/respository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/models/analytics_info_model.dart';
import 'package:expertis/utils/BMColors.dart';

class AdminAnalyticsViewModel with ChangeNotifier {
  final _myRepo = UserRepository();

  Map<String, AnalyticInfo> adminAnalyticsData = {
    'total_users': AnalyticInfo(
      svgSrc: 'assets/svg/user.svg',
      title: 'Users',
      count: 200,
      color: bmSpecialColor,
    ),
    'total_shops': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Shops',
      count: 30,
      color: bmPrimaryColor,
    ),
    'total_services': AnalyticInfo(
      svgSrc: 'assets/svg/task.svg',
      title: 'Services',
      count: 287,
      color: bmPrimaryColor,
    ),
    'total_categories': AnalyticInfo(
      svgSrc: 'assets/svg/bug.svg',
      title: 'Categories',
      count: 10,
      color: bmPrimaryColor,
    ),
    'total_appointments': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'Appointments',
      count: 2000,
      color: bmPrimaryColor,
    ),
    'more': AnalyticInfo(
      svgSrc: 'assets/svg/feature.svg',
      title: 'More Analytics',
      color: bmPrimaryColor,
    ),
  };

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<dynamic> analyticsData = ApiResponse.loading();

  setCategoryList(ApiResponse<dynamic> response) {
    // print('response in setting ${response.data!.toJson()}');
    analyticsData = response;
    notifyListeners();
  }

  Future<void> fetchAdminAnalyticsDataApi() async {
    setCategoryList(ApiResponse.loading());

    _myRepo.fetchAdminAnalytics().then((value) {
      print("value is ${value}");
      adminAnalyticsData['total_users']?.count = value["data"]['noOfUsers'];
      adminAnalyticsData['total_shops']?.count = value["data"]['noOfShops'];
      adminAnalyticsData['total_services']?.count =
          value["data"]['noOfServices'];
      adminAnalyticsData['total_categories']?.count = value["data"]['noOfTags'];
      adminAnalyticsData['total_appointments']?.count =
          value["data"]['noOfAppointments'];

      print("value is ${value}");
      setCategoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // print("error ${error.toString()}");
      setCategoryList(ApiResponse.error(error.toString()));
    });
  }
}
