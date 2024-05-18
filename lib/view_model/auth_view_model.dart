import 'package:arch_movie/responsitory/auth_responsitory.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
    await _myRepo
        .loginApi(data)
        .then((value) => {
              setLoading(false),
              if (kDebugMode)
                {print(value.toString()), Utils.snackBar("Login Successfully", context)}
            })
        .onError((error, stackTrace) => {
              setLoading(false),
              if (kDebugMode)
                {print(error.toString()), Utils.flushBarErrorFlutter(error.toString(), context)}
            });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    await _myRepo
        .registerApi(data)
        .then((value) => {
              setLoading(false),
              if (kDebugMode)
                {print(value.toString()), Utils.snackBar("Register Successfully", context)}
            })
        .onError((error, stackTrace) => {
              setLoading(false),
              if (kDebugMode)
                {print(error.toString()), Utils.flushBarErrorFlutter(error.toString(), context)}
            });
  }
}
