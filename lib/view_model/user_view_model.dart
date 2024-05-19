import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/responsitory/user_repository.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  final _myRepo = UserRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> saveTokenUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", userModel.token.toString());
    _userModel = userModel;
    notifyListeners();
    return true;
  }

  Future<UserModel?> getTokenUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null || token.isEmpty || token == 'null') {
      return null;
    }

    _userModel = UserModel(token: token);
    notifyListeners();
    return _userModel;
  }

  Future<bool> removeTokenUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    _userModel = null;
    notifyListeners();
    return true;
  }

  Future<void> fetchApiListUser(BuildContext context) async {
    setLoading(true);
    await _myRepo.fetchListUserApi().then((value) {
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
        Utils.snackBar("Fetch List User Successfully", context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
        Utils.flushBarErrorFlutter(error.toString(), context);
      }
    });
  }
}
