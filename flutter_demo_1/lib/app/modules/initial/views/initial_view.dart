import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/widgets/custom_top_tabbar.dart';
import 'package:get/get.dart';

import '../controllers/initial_controller.dart';

class InitialView extends GetWidget<InitialController> {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopTabBar.header(
              // backPress: Get.toNamed(Routes.INITIAL),
              backPress: () => print("Tapped"),
              title: 'Tussly',
            ),
            SizedBox(height: 50),
            Expanded(
              child: const Center(
                child: Text(
                  'InitialView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
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
