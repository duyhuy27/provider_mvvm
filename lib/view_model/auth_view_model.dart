import 'package:arch_movie/data/shared_preferences.dart';
import 'package:arch_movie/responsitory/auth_responsitory.dart';
import 'package:arch_movie/utils/application.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
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

  Future<void> loginApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // setLoading(true);
    // await _myRepo
    //     .loginApi(data)
    //     .then((value) => {
    //           setLoading(false),
    //           if (kDebugMode)
    //             {
    //               print(value.toString()),
    //               Utils.snackBar("Login Successfully", context)
    //             }
    //         })
    //     .onError((error, stackTrace) => {
    //           setLoading(false),
    //           if (kDebugMode)
    //             {
    //               print(error.toString()),
    //               Utils.flushBarErrorFlutter(error.toString(), context)
    //             }
    //         });

    setLoading(true);
    final res = await _myRepo.loginApi(
        context: context, email: email, password: password);
    setLoading(false);
    if (res.success) {
      await Prefs.set(PreferencesKey.token, res.result);
      Navigator.popAndPushNamed(context, RoutesName.home);
    } else {
      Utils.flushBarErrorFlutter(res.message, context);
    }
  }

  Future<void> registerApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // setLoading(true);
    // await _myRepo
    //     .registerApi(data)
    //     .then((value) => {
    //           setLoading(false),
    //           if (kDebugMode)
    //             {
    //               print(value.toString()),
    //               Utils.snackBar("Register Successfully", context)
    //             }
    //         })
    //     .onError((error, stackTrace) => {
    //           setLoading(false),
    //           if (kDebugMode)
    //             {
    //               print(error.toString()),
    //               Utils.flushBarErrorFlutter(error.toString(), context)
    //             }
    //         });
    setLoading(true);
    final res = await _myRepo.registerApi(
        context: context, email: email, password: password);
    setLoading(false);
    if (res.success) {
      await Prefs.set(PreferencesKey.token, res.result);
      Navigator.popAndPushNamed(context, RoutesName.home);
    } else {
      Utils.flushBarErrorFlutter(res.message, context);
    }
  }

  Future logout(BuildContext context) async {
    setLoading(true);
    await Application.logout(context);
    setLoading(false);
  }
}
