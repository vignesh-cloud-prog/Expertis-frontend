import 'package:expertis/data/response/api_response.dart';
import 'package:expertis/respository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<dynamic> homeData = ApiResponse.loading();

  setMoviesList(ApiResponse<dynamic> response) {
    homeData = response;
    if (kDebugMode) {
      print("response ${homeData.toString()}");
    }
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
