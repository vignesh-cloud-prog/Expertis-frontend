import 'package:beamer/beamer.dart';
import 'package:expertis/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/routes/routes_name.dart';
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
      Beamer.of(context).beamToNamed(RoutesName.verifyOTP);
      if (kDebugMode) {
        // print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
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
        Beamer.of(context).beamToNamed(RoutesName.verifyOTP);
        Utils.flushBarErrorMessage('Email verification required', context);
      } else {
        final userViewModel =
            Provider.of<UserViewModel>(context, listen: false);
        userViewModel.saveUser(UserModel.fromJson(value['data']));
        userViewModel.saveToken(value['data']['token']);
        // Utils.flushBarErrorMessage('Login Successfully', context);
        if (kDebugMode) {
          UserViewModel.getUser();
        }

        Beamer.of(context).beamToNamed(RoutesName.home);
        Utils.toastMessage("Login Successfully");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        // print(error.toString());
      }
    });
  }

  ApiResponse<dynamic> verifyTokenResponse = ApiResponse.loading();

  setVerifyTokenResponse(ApiResponse<dynamic> response) {
    verifyTokenResponse = response;
    notifyListeners();
  }

  Future<void> verifyToken() async {
    await Future.delayed(const Duration(seconds: 1));
    _myRepo.verifyTokenApi().then((value) {
      setVerifyTokenResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // print("error ${error}");
      setVerifyTokenResponse(ApiResponse.error(error.toString()));
    });
  }

  Future<void> forgotPasswordApi(dynamic data, BuildContext context) async {
    setForgetPasswordLoading(true);

    _myRepo.forgetPasswordApi(data).then((value) {
      setForgetPasswordLoading(false);
      // print(value.toString());
      Utils.toastMessage("OTP sent");

      email = value['data']['email'];
      hash = value['data']['hash'];
      Beamer.of(context).beamToNamed(RoutesName.changePassword);
    }).onError((error, stackTrace) {
      setForgetPasswordLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        // print(error.toString());
        // print(stackTrace.toString());
      }
    });
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.changePasswordApi(data).then((value) {
      setLoading(false);

      if (kDebugMode) {
        // print(value.toString());
      }
      Utils.toastMessage("Password changed successfully");
      Utils.flushBarErrorMessage('Password Reset Successfully', context);
      Beamer.of(context).beamToReplacementNamed(RoutesName.loginNow);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        // print(error.toString());
      }
    });
  }

  Future<void> verifyOTP(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.verifyOTP(data).then((value) {
      // print('value: $value');
      setLoading(false);
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      userViewModel.saveUser(UserModel.fromJson(value['data']));
      userViewModel.saveToken(value['data']['token']);
      Beamer.of(context).beamToNamed(RoutesName.createProfile);
      Utils.toastMessage("OTP verified successfully");
      if (kDebugMode) {
        // print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (!kDebugMode) {
        // print(error.toString());
      }
    });
  }
}
