import 'package:flutter/cupertino.dart';
import 'package:expertis/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  String? email;
  String? name;
  String? phone;
  List<String>? role;
  String? date;
  bool? verified;
  List<String>? shop;
  List<String>? appointments;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? token;

  Future setUserViewModel() async {
    UserModel user = await getUser();
    email = user.email;
    name = user.name;
    phone = user.phone;
    role = user.role;
    date = user.date;
    verified = user.verified;
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
    sp.setString('date', user.date.toString());
    sp.setBool('verified', user.verified ?? false);
    sp.setStringList('shop', user.shop ?? []);
    sp.setStringList('appointments', user.appointments ?? []);
    sp.setString('createdAt', user.createdAt.toString());
    sp.setString('updatedAt', user.updatedAt.toString());
    sp.setStringList('role', user.role ?? []);

    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    final String? id = sp.getString('id');
    final String? name = sp.getString('name');
    final String? email = sp.getString('email');
    final String? phone = sp.getString('phone');
    final String? date = sp.getString('date');
    final bool? verified = sp.getBool('verified');
    final List<String>? shop = sp.getStringList('shop');
    final List<String>? appointments = sp.getStringList('appointments');
    final String? createdAt = sp.getString('createdAt');
    final String? updatedAt = sp.getString('updatedAt');
    final List<String>? role = sp.getStringList('role');

    return UserModel(
      token: token,
      id: id,
      name: name,
      email: email,
      phone: phone,
      date: date,
      verified: verified,
      shop: shop,
      appointments: appointments,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: role,
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
