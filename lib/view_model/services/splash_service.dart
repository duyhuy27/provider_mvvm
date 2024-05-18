import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SplashService {
  Future<UserModel?> getUserDate() => UserViewModel().getTokenUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      print(value!.token);
      if (value!.token != 'null' || value.token != "") {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RoutesName.home);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RoutesName.login);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Error: $error');
      }
    });
  }
}
