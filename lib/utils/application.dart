import 'package:arch_movie/data/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import 'routes/routes_name.dart';

class Application {
  static Future logout(BuildContext context) async {
    Prefs.deleteAll();
    Navigator.pushNamed(context, RoutesName.login);
  }
}
