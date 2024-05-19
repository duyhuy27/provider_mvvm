import 'package:arch_movie/controllers/login_controller.dart';
import 'package:arch_movie/res/component/round_button.dart';
import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:arch_movie/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginView> {
  late final controller = LoginController(context);

  @override
  void initState() {
    super.initState();
    controller.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onReady();
    });
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.light,
              focusNode: controller.emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(context, controller.emailFocusNode,
                    controller.passwordFocusNode);
              },
              decoration: const InputDecoration(
                hintText: "Your email address",
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isObscure.value,
                focusNode: controller.passwordFocusNode,
                onFieldSubmitted: (value) {
                  controller.passwordFocusNode.unfocus();
                },
                keyboardType: TextInputType.visiblePassword,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Your password",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isObscure(!controller.isObscure.value);
                        },
                        icon: Icon(controller.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() => RoundButton(
                  title: "Login",
                  onPressed: controller.login,
                  isLoading: controller.loading.value,
                )),
            SizedBox(
              height: 15,
            ),
            RoundButton(
              title: "Sign Up",
              onPressed: () {
                Navigator.popAndPushNamed(context, RoutesName.register);
              },
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}
