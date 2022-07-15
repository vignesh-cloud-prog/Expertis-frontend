import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/respository/category_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CategoryViewModel with ChangeNotifier {
  final _myRepo = CategoryRepository();

  ApiResponse<CategoryListModel> categoryList = ApiResponse.loading();

  setCategoryList(ApiResponse<CategoryListModel> response) {
    // print('response in setting ${response.data!.toJson()}');
    categoryList = response;
    notifyListeners();
  }

  Future<void> fetchCategoryListApi() async {
    setCategoryList(ApiResponse.loading());

    _myRepo.fetchCategoryList().then((value) {
      // print("value is ${value.toJson()}");
      setCategoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // print("error ${error.toString()}");
      setCategoryList(ApiResponse.error(error.toString()));
    });
  }
}
