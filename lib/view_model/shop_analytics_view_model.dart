import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/models/analytics_info_model.dart';
import 'package:expertis/utils/BMColors.dart';

class ShopAnalyticsViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  Map<String, AnalyticInfo> ShopAnalyticsData = {
    'views': AnalyticInfo(
      svgSrc: 'assets/svg/user.svg',
      title: 'Views',
      count: 1200,
      color: bmSpecialColor,
    ),
    'favorites': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Favorites',
      count: 30,
      color: bmPrimaryColor,
    ),
    'reviews': AnalyticInfo(
      svgSrc: 'assets/svg/task.svg',
      title: 'Reviews',
      count: 28,
      color: bmPrimaryColor,
    ),
    'services': AnalyticInfo(
      svgSrc: 'assets/svg/bug.svg',
      title: 'Services',
      count: 14,
      color: bmPrimaryColor,
    ),
    'total_appointments': AnalyticInfo(
      svgSrc: 'assets/svg/project.svg',
      title: 'Total Appointments',
      count: 300,
      color: bmPrimaryColor,
    ),
    // 'completed': AnalyticInfo(
    //   svgSrc: 'assets/svg/task.svg',
    //   title: 'Completed',
    //   count: 200,
    //   color: bmPrimaryColor,
    // ),
    // 'pending': AnalyticInfo(
    //   svgSrc: 'assets/svg/bug.svg',
    //   title: 'Pending',
    //   count: 12,
    //   color: bmPrimaryColor,
    // ),
    // 'confirmed': AnalyticInfo(
    //   svgSrc: 'assets/svg/feature.svg',
    //   title: 'Confirmed',
    //   count: 8,
    //   color: bmPrimaryColor,
    // ),
    // 'cancelled': AnalyticInfo(
    //   svgSrc: 'assets/svg/feature.svg',
    //   title: 'Canceled',
    //   count: 30,
    //   color: bmPrimaryColor,
    // ),
    // 'rejected': AnalyticInfo(
    //   svgSrc: 'assets/svg/feature.svg',
    //   title: 'Rejected',
    //   count: 50,
    //   color: bmPrimaryColor,
    // ),
  };

  ApiResponse<dynamic> analyticsData = ApiResponse.loading();

  setCategoryList(ApiResponse<dynamic> response) {
    // print('response in setting ${response.data!.toJson()}');
    analyticsData = response;
    notifyListeners();
  }

  Future<void> fetchShopAnalyticsDataApi(String? shopId) async {
    setCategoryList(ApiResponse.loading());

    _myRepo.fetchShopAnalytics(shopId).then((value) {
      print("value is ${value}");
      ShopAnalyticsData['views']!.count = value["data"]['views'].length;
      ShopAnalyticsData['favorites']!.count =
          value["data"]["shop"]['likes'].length;
      ShopAnalyticsData['reviews']!.count =
          value["data"]["shop"]['reviews'].length;
      ShopAnalyticsData['services']!.count =
          value["data"]["shop"]['services'].length;
      ShopAnalyticsData['total_appointments']!.count =
          value["data"]["shop"]['appointments'].length;
      // ShopAnalyticsData['completed']!.count =
      //     value["data"]['appointments']["completed"];
      // ShopAnalyticsData['pending']!.count =
      //     value["data"]['appointments']["pending"];
      // ShopAnalyticsData['confirmed']!.count =
      //     value["data"]['appointments']["confirmed"];
      // ShopAnalyticsData['cancelled']!.count =
      //     value["data"]['appointments']["cancelled"];
      // ShopAnalyticsData['rejected']!.count =
      //     value["data"]['appointments']["rejected"];

      print("value is ${value}");
      setCategoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // print("error ${error.toString()}");
      setCategoryList(ApiResponse.error(error.toString()));
    });
  }
}
