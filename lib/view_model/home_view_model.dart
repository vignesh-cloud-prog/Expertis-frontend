import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/respository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<dynamic> homeData = ApiResponse.loading();

  setHomeData(ApiResponse<dynamic> response) {
    homeData = response;
    if (kDebugMode) {
      print("response ${homeData.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchHomeDataApi() async {
    setHomeData(ApiResponse.loading());

    _myRepo.fetchHomeData().then((value) {
      setHomeData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHomeData(ApiResponse.error(error.toString()));
    });
  }
}
