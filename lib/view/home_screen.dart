import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/view_model/services/splash_service.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel = UserModel();
  final SplashService _splashService = SplashService();
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    userViewModel.getTokenUser();
    userViewModel.fetchApiListUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final token = userViewModel.userModel?.token ?? 'No token';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: InkWell(
          child: Column(
            children: [
              Text('Token: ${token}'),
            ],
          ),
          onTap: () {
            userViewModel.removeTokenUser().then((value) {
              Navigator.pushNamed(context, RoutesName.login);
            });
          },
        ),
      ),
    );
  }
}
