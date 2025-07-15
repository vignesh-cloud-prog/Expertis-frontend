import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/models/categories_model.dart';
import 'package:expertis/respository/category_repository.dart';
import 'package:expertis/routes/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CategoryViewModel with ChangeNotifier {
  final _myRepo = CategoryRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

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

  Future<void> sendCategoryData(
      bool isEditMode,
      Map<String, String> data,
      bool isFileSelected,
      Map<String, dynamic> files,
      BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('data: $data');
      print('files: $files');
    }
    _myRepo
        .uploadCategoryDataApi(isEditMode, data, isFileSelected, files)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Beamer.of(context).beamToReplacementNamed(RoutesName.adminTags);
      Utils.flushBarErrorMessage('successfully', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }

  Future<void> deleteCategoryApi(String? id, BuildContext context) async {
    setLoading(true);
    if (kDebugMode) {
      print('id: $id');
    }
    _myRepo.deleteCategory(id).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      // userViewModel.saveUser(UserModel.fromJson(value['data']));
      setLoading(false);
      Utils.toastMessage(' successfully deleted');
      categoryList.data?.categories!.removeWhere((element) => element.id == id);
      Beamer.of(context).beamToReplacementNamed(RoutesName.adminTags);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
      }
    });
  }
}
