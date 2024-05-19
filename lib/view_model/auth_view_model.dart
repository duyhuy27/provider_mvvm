import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/responsitory/auth_responsitory.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      if (kDebugMode) {
        print("Value: " + value.toString());
        Utils.snackBar("Login Successfully", context);
      }
      UserModel userModel = UserModel(token: value.toString());
      await Provider.of<UserViewModel>(context, listen: false).saveTokenUser(userModel);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
        Utils.flushBarErrorFlutter(error.toString(), context);
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo.registerApi(data).then((value) {
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
        Utils.snackBar("Register Successfully", context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
        Utils.flushBarErrorFlutter(error.toString(), context);
      }
    });
  }

  //function fetch api list user
}
