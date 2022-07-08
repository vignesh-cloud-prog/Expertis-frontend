import 'package:flutter/cupertino.dart';
import 'package:expertis/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  String email = "vignesh@xmail.com";
  String name = "Vignesh";
  String? phone;
  String? role;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
  String? createdAt;
  String? updatedAt;
  String userPic =
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.pixabay.com%2Fphoto%2F2015%2F10%2F05%2F22%2F37%2Fblank-profile-picture-973460_1280.png&imgrefurl=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&tbnid=H6pHpB03ZEAgeM&vet=12ahUKEwigm-bJnun4AhWm_zgGHfolDUAQMygBegUIARDZAQ..i&docid=wg0CyFWNfK7o5M&w=1280&h=1280&q=profile%20picture&ved=2ahUKEwigm-bJnun4AhWm_zgGHfolDUAQMygBegUIARDZAQ';
  String? id;
  String? token;
  String? message;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future setUserViewModel() async {
    UserModel user = await getUser();
    email = user.email;
    name = user.name;
    phone = user.phone;
    role = user.role;
    userPic = user.userPic;
    verified = user.verified ?? false;
    shop = user.shop;
    appointments = user.appointments;
    createdAt = user.createdAt;
    updatedAt = user.updatedAt;
    id = user.id;
    token = user.token;
  }

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setString('id', user.id.toString());
    sp.setString('name', user.name.toString());
    sp.setString('email', user.email.toString());
    sp.setString('phone', user.phone.toString());
    sp.setString('userPic', user.userPic.toString());
    sp.setBool('verified', user.verified ?? false);
    sp.setStringList('shop', user.shop ?? []);
    sp.setStringList('appointments', user.appointments ?? []);
    sp.setString('createdAt', user.createdAt.toString());
    sp.setString('updatedAt', user.updatedAt.toString());
    sp.setString('role', user.role.toString());

    notifyListeners();
    return true;
  }

  static Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    final String? id = sp.getString('id');
    final String name = sp.getString('name') ?? 'John Doe';
    final String email = sp.getString('email') ?? 'example@email.com';
    final String? phone = sp.getString('phone');
    final bool verified = sp.getBool('verified') ?? false;
    final List<String>? shop = sp.getStringList('shop');
    final List<String>? appointments = sp.getStringList('appointments');
    final String? createdAt = sp.getString('createdAt');
    final String? updatedAt = sp.getString('updatedAt');
    final String? role = sp.getString('role');
    final String userPic = sp.getString('userPic') ?? 'images/face_two.jpg';

    return UserModel(
      token: token,
      id: id,
      name: name,
      email: email,
      phone: phone,
      verified: verified,
      shop: shop,
      appointments: appointments,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role,
      userPic: userPic,
    );
  }

  static Future<String> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token') ?? 'dummy';

    return token.toString();
  }

  static Future<String> getUserId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? id = sp.getString('id');

    return id.toString();
  }

  Future<bool> logout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('id');
    await sp.remove('name');
    await sp.remove('email');
    await sp.remove('phone');
    await sp.remove('date');
    await sp.remove('verified');
    await sp.remove('shop');
    await sp.remove('appointments');
    await sp.remove('createdAt');
    await sp.remove('updatedAt');
    await sp.remove('role');
    notifyListeners();
    return true;
  }
}
