import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_strings.dart';
import '../../../core/helper/images_resources.dart';
import '../../../widgets/custom_top_tabbar.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetWidget<SignupController> {
  const SignupView({super.key});
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
                            "Create an Account",
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
                          SizedBox(height: 30.0),
                          Text(
                            "Required Information",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          // Email TextField
                          TextField(
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
                            decoration: InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Display Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.badge),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.0),
                          TextField(
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
                          SizedBox(height: 10.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            obscureText: true, // 👈 hides the password
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            "Optional Information",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          // First Name
                          TextField(
                            decoration: InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.account_circle),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 10), // spacing between fields
                          // Last Name
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle_outlined,
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 25.0),
                          SizedBox(height: 25.0),
                          GestureDetector(
                            onTap: () {
                              // 👉 Handle your tap action here
                              print("Submit tapped");
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
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 16, // change size as needed
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
    );
  }
}
