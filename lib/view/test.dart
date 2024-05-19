import 'package:arch_movie/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TestController? controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("asdasd"),
      ),
      body: GestureDetector(
        onTap: () {
          controller?.text("from test page");
        },
        child: Center(
          child: Obx(() => Text(controller?.text.value ?? '')),
        ),
      ),
    );
  }
}
