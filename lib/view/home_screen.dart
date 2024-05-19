import 'package:arch_movie/res/component/loading_widget.dart';
import 'package:arch_movie/utils/application.dart';
import 'package:arch_movie/view/test.dart';
import 'package:arch_movie/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/test_controller.dart';
import 'test_singleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TestController? getXcontroller;
  late UserViewModel controller;
  // UserModel? userModel = UserModel();
  // final SplashService _splashService = SplashService();

  @override
  void initState() {
    super.initState();
    getXcontroller = Get.put(TestController());
    // _splashService.getUserData().then((user) {
    //   if (user != null || user != "") {
    //     userModel = user;
    //     if (kDebugMode) {
    //       print('User: ${userModel!.token.toString()}');
    //     }
    //   }
    // });
    controller = Provider.of<UserViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserData(context);
    });
  }

  @override
  void dispose() {
    Get.delete<TestController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Provider.of<UserViewModel>(context).loading
          ? const LoadingWidget()
          : ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      controller.user.avatar ?? '',
                      width: 120,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 90,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Obx(() => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const TestPage()));
                        // getXcontroller?.text("from home 2");
                      },
                      child: item("test value", getXcontroller?.text.value),
                    )),
                item("Email", controller.user.email),
                item("First Name", controller.user.firstName),
                item("Last Name", controller.user.lastName),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Singleton().test();
                      // Application.logout(context);
                    },
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),
    );
  }

  Widget item(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            value ?? '',
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }
}
