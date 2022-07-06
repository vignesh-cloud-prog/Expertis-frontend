import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expertis/models/user_model.dart';
import 'package:expertis/respository/auth_repository.dart';
import 'package:expertis/utils/routes_name.dart';
import 'package:expertis/utils/utils.dart';
import 'package:expertis/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:expertis/utils/apiClasses/changePassword.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));

      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
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

  Future<void> forgotPasswordApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.forgetPasswordApi(data).then((value) {
      setLoading(false);
      print(value.toString());
      Utils.toastMessage("OTP sent");
      print("hash: ${value['data']['hash']}");
      print("email: ${value['data']['email']}");
      Navigator.pushNamed(context, RoutesName.changePassword,
          arguments: ChangePasswordArguments(
              value!['data']!['hash'], value!['data']!['email']));
    }).onError((error, stackTrace) {
      setLoading(false);
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
      // final userPreference = Provider.of<UserViewModel>(context, listen: false);
      // userPreference.saveUser(UserModel(token: value['token'].toString()));
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

  Future<void> signUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      print("hash: ${value['data']['hash']}");
      print("id: ${value['data']['id']}");
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
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
}
