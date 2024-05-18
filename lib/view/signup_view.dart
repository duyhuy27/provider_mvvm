import 'package:arch_movie/utils/routes/routes_name.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/component/round_button.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  //controller for email and password
  final TextEditingController _emailController =
      TextEditingController(text: 'eve.holt@reqres.in');
  final TextEditingController _passwordController =
      TextEditingController(text: 'pistol');

  //flag to show/hide password
  bool _isObscure = true;

  //focus node for email and password
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp Screen",
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.light,
              focusNode: _emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, _emailFocusNode, _passwordFocusNode);
              },
              decoration: const InputDecoration(
                hintText: "Your email address",
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscure,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (value) {
                _passwordFocusNode.unfocus();
              },
              keyboardType: TextInputType.visiblePassword,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Your password",
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(_isObscure
                          ? Icons.visibility
                          : Icons.visibility_off))),
            ),
            SizedBox(
              height: height * .085,
            ),
            RoundButton(
              title: "SignUp",
              onPressed: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorFlutter("Email is empty", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorFlutter("Password is empty", context);
                } else {
                  authViewModel.registerApi(
                    context: context,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  // Navigator.pushNamed(context, RoutesName.home);
                }
              },
              isLoading: authViewModel.isLoading,
            ),
            SizedBox(
              height: height * .02,
            ),
            RoundButton(
              title: "Login Up",
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}
