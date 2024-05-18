import 'package:arch_movie/view_model/services/splash_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashService _splashService = SplashService();

  /// Simulate a loading in progress loading for [loadingTime] seconds
  final loadingTime = 5;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: loadingTime)).then((_) {
        _splashService.initiateApp(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 150,
            ),
            SizedBox(height: 20),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
