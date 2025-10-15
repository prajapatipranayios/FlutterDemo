import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:flutter_demo_1/app/widgets/custom_top_tabbar.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('LoginView'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            TopTabBar.header(
              // backPress: Get.toNamed(Routes.INITIAL),
              backPress: () => print("Tapped"),
              title: AppString.tussly,
            ),
            //SizedBox(height: 10),
            Expanded(child: Text("Hello")),
            //SizedBox(height: 10),
            TopTabBar.footer(
              context: context,
              backPress: () => print("Tapped"),
              title: "Footer Title",
            ),
          ],
        ),
      ),
    );
  }
}
