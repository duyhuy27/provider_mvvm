import 'package:arch_movie/model/user_model.dart';

import '../utils/application.dart';

class Singleton {
  void test() {
    final app1 = Application();
    final app2 = Application();
    final app3 = Application();
    app1.user.firstName = 'name3';
    print(app1.user.firstName);
    print(app2.user.firstName);

    app2.user.firstName = 'name7';
    print(app1.user.firstName);
  }
}

final app = Application._private();

class Application {
  Application._private();
  static Application _instance = Application._private();
  factory Application() {
    return _instance;
  }

  UserModel user = UserModel();
}
