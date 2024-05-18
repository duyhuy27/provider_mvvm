import 'package:arch_movie/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  Future<bool> saveTokenUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", userModel.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel?> getTokenUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    return UserModel(token: token.toString());
  }

  Future<bool> removeTokenUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    return true;
  }
}
