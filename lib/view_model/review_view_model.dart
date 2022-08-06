import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
// import 'package:expertis/models/categories_model.dart';
import 'package:expertis/models/review_model.dart';
import 'package:expertis/models/shop_model.dart';
import 'package:expertis/respository/review_repository.dart';
// import 'package:expertis/respository/category_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ReviewViewModel with ChangeNotifier {
  final _myRepo = ReviewRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ReviewModel> review = ApiResponse.loading();

  setReview(ApiResponse<ReviewModel> response) {
    // print('response in setting ${response.data!.toJson()}');
    review = response;
    notifyListeners();
  }

  Future<void> addOrUpdateReviewData(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic?> files,
      BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('data: $data');
      // print('files: $files');
    }
    _myRepo
        .createOrUpdateReviewDataApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        print("vale of the review ${value['data']}");
      }
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // ShopModel reviews = ShopModel.fromJson(value[data[to['shopId']]]);
      // ReviewModel? reviews = ReviewModel();
      setLoading(false);
      // print("Routed to home ${reviews.to}");
      String shopId = value['data']['id'];
      print("shop id $shopId");
      Beamer.of(context)
          .beamToReplacementNamed(RoutesName.viewShopWithId(shopId));
      Utils.flushBarErrorMessage('successfully', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  // Future<void> deleteShopReviewApi(String? id, BuildContext context) async {
  //   setLoading(true);
  //   if (kDebugMode) {
  //     print('id: $id');
  //   }
  //   _myRepo.deleteReview(id).then((value) {
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //     // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
  //     // userViewModel.saveUser(UserModel.fromJson(value['data']));
  //     setLoading(false);
  //     Utils.toastMessage(' successfully deleted');
  //     // categoryList.data?.categories!.removeWhere((element) => element.id == id);
  //     Beamer.of(context).beamToReplacementNamed(RoutesName.adminTags);
  //   }).onError((error, stackTrace) {
  //     setLoading(false);
  //     Utils.flushBarErrorMessage(error.toString(), context);
  //     if (kDebugMode) {
  //       // print(error.toString());
  //     }
  //   });
  // }
}
