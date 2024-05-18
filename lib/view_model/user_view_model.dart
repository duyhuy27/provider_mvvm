import 'package:arch_movie/data/shared_preferences.dart';
import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/responsitory/auth_responsitory.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  bool loading = false;
  UserModel user = UserModel();

  Future getUserData(BuildContext context) async {
    loading = true;
    notifyListeners();
    final res = await AuthRepository().getUserData(
      context: context,
      id: 1,
    );
    loading = false;
    notifyListeners();

    if (res.success) {
      user = res.result!;
      notifyListeners();
    } else {
      Utils.flushBarErrorFlutter(res.message, context);
    }
  }

  Future<bool> saveTokenUser(String token) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("token", userModel.token.toString());
    // notifyListeners();
    // return true;
    return await Prefs.set<String?>(PreferencesKey.token, token);
  }

  String getTokenUser() {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString("token");

    // return UserModel(token: token.toString());
    return Prefs.get<String>(PreferencesKey.token);
  }

  Future<bool> removeTokenUser() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("token");
    // return true;
    return await Prefs.set(PreferencesKey.token, '');
  }
}
