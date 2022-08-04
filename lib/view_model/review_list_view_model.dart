import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/review_list_model.dart';
import 'package:expertis/models/shop_list_model.dart';
import 'package:expertis/respository/review_repository.dart';
import 'package:expertis/respository/shop_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ReviewListViewModel with ChangeNotifier {
  final _myRepo = ReviewRepository();

  ApiResponse<ReviewListModel> reviewList = ApiResponse.loading();
  ApiResponse<ReviewListModel> nearbyShopList = ApiResponse.loading();

  setReviewList(ApiResponse<ReviewListModel> response) {
    reviewList = response;
    // if (kDebugMode) {
    //   // print("response ${shopList.toString()}");
    // }
    notifyListeners();
  }

  setNearbyShopList(ApiResponse<ReviewListModel> response) {
    nearbyShopList = response;
    // if (kDebugMode) {
    //   // print("response ${nearbyShopList.toString()}");
    // }
    notifyListeners();
  }

  Future<void> fetchReviewDataApi(id) async {
    _myRepo.getAllReviewOfShop(id).then((value) {
      print("api response in getAllReviewOfShop ${value}");
      setReviewList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setReviewList(ApiResponse.error(error.toString()));
    });
  }
}
