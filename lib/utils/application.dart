import 'package:arch_movie/data/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import 'routes/routes_name.dart';

class Application {
  static var user = UserModel().obs;

  static Future logout(BuildContext context) async {
    Prefs.deleteAll();
    Navigator.pushNamed(context, RoutesName.login);
  }
}
