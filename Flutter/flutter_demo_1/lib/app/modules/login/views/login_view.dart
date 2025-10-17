import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:flutter_demo_1/app/widgets/custom_top_tabbar.dart';
import 'package:get/get.dart';

import '../../../core/helper/images_resources.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('LoginView'), centerTitle: true),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        }, // 👈 hides the keyboard},
        child: SafeArea(
          child: Column(
            children: [
              TopTabBar.header(
                // backPress: Get.toNamed(Routes.INITIAL),
                backPress: () => print("Tapped"),
                title: AppString.tussly,
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: Get.back,
                            child: Padding(
                              //padding: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Image.asset(
                                ImageResources.back,
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login with Tussly",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "to Continue",
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 120.0),

                            // Email TextField
                            TextField(
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                              ),
                              obscureText: true, // 👈 hides the password
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 25.0),
                            Obx(
                              () => InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  print("Radio button tap - Remember me.");
                                  controller.isRemembered.value =
                                      !controller.isRemembered.value;
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      groupValue: controller.isRemembered.value,
                                      onChanged: (value) {
                                        controller.isRemembered.value =
                                            !controller.isRemembered.value;
                                      },
                                    ),
                                    const Text(
                                      "Remember me",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            GestureDetector(
                              onTap: () {
                                // 👉 Handle your tap action here
                                controller.login();
                                print("Login tapped");
                              },
                              child: Container(
                                alignment: Alignment.center, // center the text
                                width: double.infinity, // same as Get.width
                                height: 50, // fixed height
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ), // left & right padding
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // rounded corners
                                ),

                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16, // change size as needed
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Center(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("Forgot password tap.");
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  InkWell(
                                    onTap: () {
                                      print("Register");
                                    },
                                    child: Text(
                                      "New User? Register with Tussly.",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 10),
              TopTabBar.footer(
                context: context,
                backPress: () => print("Tapped"),
                title: "Footer Title",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
