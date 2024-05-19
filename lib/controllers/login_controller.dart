import 'package:arch_movie/responsitory/auth_responsitory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/shared_preferences.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class LoginController {
  final BuildContext context;
  LoginController(this.context);

  //controller for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //flag to show/hide password
  var isObscure = true.obs;
  var loading = false.obs;

  //focus node for email and password
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  Future onInit() async {}

  Future onReady() async {}

  Future onDispose() async {}

  void forgotPassword() {}

  void signup() {}

  Future login() async {
    // final authViewModel = Provider.of<AuthViewModel>(context);
    if (emailController.text.isEmpty) {
      Utils.flushBarErrorFlutter("Email is empty", context);
    } else if (passwordController.text.isEmpty) {
      Utils.flushBarErrorFlutter("Password is empty", context);
    } else {
      // email: eve.holt@reqres.in
      // password: pistol
      // Map data = {"email": _emailController.text, "password": _passwordController.text};

      loading(true);
      final res = await AuthRepository().loginApi(
          context: context,
          email: emailController.text,
          password: passwordController.text);
      loading(false);
      if (res.success) {
        await Prefs.set(PreferencesKey.token, res.result);
        Navigator.popAndPushNamed(context, RoutesName.home);
      } else {
        Utils.flushBarErrorFlutter(res.message, context);
      }
      // Navigator.pushNamed(context, RoutesName.home);
    }
  }
}
