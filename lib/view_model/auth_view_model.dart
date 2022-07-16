import 'package:expertis/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  String? hash;
  String? get getHash => hash;

  String? id;
  String? get getId => id;

  String? email;
  String? get getEmail => email;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  bool _forgetPasswordLoading = false;
  bool get forgetPasswordLoading => _forgetPasswordLoading;
  setForgetPasswordLoading(bool value) {
    _forgetPasswordLoading = value;
    notifyListeners();
  }

  bool _validToken = true;
  bool get validToken => _validToken;
  setValidTokenFalse() {
    _validToken = false;
    notifyListeners();
  }

  setValidTokenTrue() {
    _validToken = true;
    notifyListeners();
  }

  Future<void> signUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);

      email = value['data']['email'];
      hash = value['data']['hash'];
      id = value['data']['id'];
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.verifyOTP);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      if (kDebugMode) {
        // print(value.toString());
      }
      if (value['statusCode'] == 300) {
        email = value['data']['email'];
        hash = value['data']['hash'];
        id = value['data']['id'];
        Utils.flushBarErrorMessage('Email validation required', context);
        Navigator.pushNamed(context, RoutesName.verifyOTP);
      } else {
        final userViewModel =
            Provider.of<UserViewModel>(context, listen: false);
        userViewModel.saveUser(UserModel.fromJson(value['data']));
        userViewModel.saveToken(value['data']['token']);
        Utils.flushBarErrorMessage('Login Successfully', context);
        if (kDebugMode) {
          UserViewModel.getUser();
        }

        setValidTokenTrue();

        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        print(error.toString());
      }
    });
  }

  // Future<void> verifyToken() async {
  //   String? token = await UserViewModel.getUserToken();
  //   if (kDebugMode) {
  //     print("token: $token");
  //   }
  //   Map<String, String> header = {
  //     "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  //     "Access-Control-Allow-Credentials":
  //         "true", // Required for cookies, authorization headers with HTTPS
  //     "Access-Control-Allow-Headers":
  //         "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  //     "Access-Control-Allow-Methods": "POST, OPTIONS",
  //     'Content-Type': 'application/json',
  //     'Authorization': "$token",
  //   };

  //   if (kDebugMode) {
  //     print("header: ${header.toString()}");
  //   }

  //   _myRepo.verifyTokenApi(header).then((value) {
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //   }).onError((error, stackTrace) {
  //     setValidTokenFalse();
  //     // Navigator.pushReplacementNamed(context, RoutesName.tokenExpired);
  //     Utils.toastMessage(error.toString());
  //     if (kDebugMode) {
  //       print(error.toString());
  //       print(stackTrace.toString());
  //     }
  //   });
  // }
  ApiResponse<dynamic> verifyTokenResponse = ApiResponse.loading();

  setVerifyTokenResponse(ApiResponse<dynamic> response) {
    verifyTokenResponse = response;
    notifyListeners();
  }

  Future<void> verifyToken() async {
    setVerifyTokenResponse(ApiResponse.loading());

    _myRepo.verifyTokenApi().then((value) {
      setVerifyTokenResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print("error ${error}");
      setVerifyTokenResponse(ApiResponse.error(error.toString()));
    });
  }

  Future<void> forgotPasswordApi(dynamic data, BuildContext context) async {
    setForgetPasswordLoading(true);

    _myRepo.forgetPasswordApi(data).then((value) {
      setForgetPasswordLoading(false);
      print(value.toString());
      Utils.toastMessage("OTP sent");

      email = value['data']['email'];
      hash = value['data']['hash'];
      Navigator.pushNamed(context, RoutesName.changePassword);
    }).onError((error, stackTrace) {
      setForgetPasswordLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    });
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.changePasswordApi(data).then((value) {
      setLoading(false);

      if (kDebugMode) {
        print(value.toString());
      }
      Utils.toastMessage("Password changed successfully");
      Utils.flushBarErrorMessage('Password Reset Successfully', context);
      Navigator.pushReplacementNamed(context, RoutesName.loginNow);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> verifyOTP(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.verifyOTP(data).then((value) {
      print('value: $value');
      setLoading(false);
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.saveUser(UserModel.fromJson(value['data']));
      userViewModel.saveToken(value['data']['token']);

      Utils.flushBarErrorMessage('Verified successfully', context);

      Navigator.pushReplacementNamed(context, RoutesName.createProfile);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        print(error.toString());
      }
    });
  }
}
