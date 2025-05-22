import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/images_resources.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetWidget<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('ASDAF'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('SplashView is working', style: TextStyle(fontSize: 25)),
            //SizedBox(height: 50),
            // Icon(Icons.access_alarms_outlined),
            Image.asset(ImageResources.swift, width: 150, height: 150),
          ],
          // Image(
          //   image: Icon(Icons.access_alarms_outlined),
          //   width: 150,
          //   height: 150,
          // ),
        ),
      ),
    );
  }
}
