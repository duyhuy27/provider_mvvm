import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/view/home_screen.dart';
import 'package:arch_movie/view/login_view.dart';
import 'package:arch_movie/view/signup_view.dart';
import 'package:arch_movie/view/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.root:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Not Found'))));
    }
  }
}
