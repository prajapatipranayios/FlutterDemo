import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_storage.dart';
import 'package:get/get.dart';

import '../../../core/helper/constants.dart';
import '../../../core/services/web_services.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isRemembered = false.obs;

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> login() async {
    final userDict = {
      "email": "af@yopmail.com",
      "password": "12345678",
      "countryCode": "91",
      "platform": "IOS",
      "osVersion": "18.4",
      "deviceOS": "iOS",
      "deviceId": "92CCAB10-655B-4BA3-95B2-8E6CC439411D",
      "deviceName": "Simulator iPhone17,1",
      "fcmToken":
          "cvmm3MsXRUQao-eJS0pEmG:APA91bFPsVvdhVJ-AE_2gg3_1ZKyz3bXqitCZGHTri6tPm7K-LH20FLHNIi-dMmFZ91CS27Idzl9peiHfLY0Wxs6ONh7wy2p6sGp5rCpcHgEMeZhRfq2Y0o",
      "type": "email",
      "timeZoneOffSet": "+05:30",
    };

    /// Call request
    await Webservice.postRequest(
      uri: Global.login,
      //body: {"email": "ad@yopmail.com", "password": "12345678"},
      body: userDict,
      hasBearer: false,
      fromJson: (json) => json, // or map to your model
      onSuccess: (data, status) {
        if (status == 1) {
          print("Login Successful: $status");
          print("Login Successful: $data");
          // Save token, navigate to home, etc.
          AppStorages.setAppLogin(true);
          Get.offAllNamed(Routes.INITIAL);
        } else if (status == 0) {
          print("Login Failed but handled in success: $data");
          // Show toast for invalid credentials, etc.
        }
      },
      onFailure: (error) {
        print("API Error: ${error.message}");
        // Show network error toast or dialog
      },
    );
  }
}
