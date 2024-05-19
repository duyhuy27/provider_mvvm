import 'dart:developer';

import 'package:arch_movie/data/shared_preferences.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';

class SplashService {
  bool get isLogin => UserViewModel().getTokenUser().isNotEmpty;

  Future initiateApp(BuildContext context) async {
    try {
      await Prefs.init();
      await checkAuthentication(context);
    } catch (e) {
      log(e.toString());
      Utils.flushBarErrorFlutter(
        "Something went wrong while initiate application. Please try again later.",
        context,
      );
    }
  }

  // Future<UserModel?> getUserData() => UserViewModel().getTokenUser();

  Future checkAuthentication(BuildContext context) async {
    // getUserData().then((value) async {
    //   print(value!.token);
    //   if (value!.token != 'null' || value.token != "") {
    //     await Future.delayed(const Duration(seconds: 2));
    //     Navigator.pushNamed(context, RoutesName.home);
    //   } else {
    //     await Future.delayed(const Duration(seconds: 2));
    //     Navigator.pushNamed(context, RoutesName.login);
    //   }
    // }).onError((error, stackTrace) {
    //   if (kDebugMode) {
    //     print('Error: $error');
    //   }
    // });

    if (isLogin) {
      // get refresh token
      // get user data
      Navigator.popAndPushNamed(context, RoutesName.home);
    } else {
      Navigator.popAndPushNamed(context, RoutesName.login);
    }
  }
}
