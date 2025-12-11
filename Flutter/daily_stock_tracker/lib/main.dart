import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  /*runApp(
    GetMaterialApp(
      title: "Daily Usage",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    ),
  );*/

  // Initialize GetStorage BEFORE runApp()
  await GetStorage.init();

  runApp(MyApp());
}

/// Separate App widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Daily Usage",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
