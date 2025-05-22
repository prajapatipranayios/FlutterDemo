import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: colorBlack, // Set the color you want
  //     statusBarIconBrightness: Brightness.light, // For white icons
  //     statusBarBrightness: Brightness.light, // For iOS
  //   ),
  // );
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(testDeviceIds: ['FB94BBFA4835755F96E9CE7C64D7385A']),
  // );

  // configEasyLoading();
  // await AppStorages().initializeApp();
  // runApp(const MyApp());

  try {
    // AppStorages.userData = userDetailModelFromJson(await AppStorages.getLoginProfileModel());
  } catch (e) {
    print("Failed to load user data: $e");
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        title: "Application",
        initialRoute: AppPages.MYROOT,
        getPages: AppPages.routes,
        // builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
      ),
    );
  });
}

//
// void configEasyLoading() {
//   EasyLoading.instance
//     ..indicatorType =
//         EasyLoadingIndicatorType
//             .circle // You can choose other types
//     ..indicatorColor =
//         themeColor // Set the loader color
//     ..loadingStyle =
//         EasyLoadingStyle
//             .custom // Use custom style to apply custom colors
//     ..backgroundColor =
//         colorBlack // Background behind the loader
//     ..textColor =
//         themeColor // Text color for the status message
//     ..maskColor = Colors.black.withValues(alpha: 0.5) // Mask overlay color
//     ..maskType =
//         EasyLoadingMaskType
//             .black // Apply a mask if needed
//     ..progressColor =
//         themeColor // Progress indicator color
//     ..userInteractions = false; // Disable user interactions while loading
// }
