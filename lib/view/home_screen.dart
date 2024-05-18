import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/view_model/services/splash_service.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel = UserModel();
  final SplashService _splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashService.getUserDate().then((user) {
      if (user != null || user != "") {
        userModel = user;
        if (kDebugMode) {
          print('User: ${userModel!.token.toString()}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = UserViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: InkWell(
          child: Text('Logout'),
          onTap: () {
            userPrefs.removeTokenUser().then((value) {
              Navigator.pushNamed(context, RoutesName.login);
            });
          },
        ),
      ),
    );
  }
}
