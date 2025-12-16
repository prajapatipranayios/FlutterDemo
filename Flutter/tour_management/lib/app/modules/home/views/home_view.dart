import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // LEFT BUTTON 👇
        // leading: IconButton(
        //   padding: EdgeInsets.zero,
        //   constraints: const BoxConstraints(),
        //   icon: Icon(
        //     Icons.inventory_outlined, // Example: Stock button
        //     color: AppColors.blackColor,
        //     size: 30,
        //   ),
        //   onPressed: () {
        //     // YOUR LEFT ACTION HERE
        //     // Get.toNamed(Routes.ADD_STOCK);
        //     Get.toNamed(Routes.STOCK_DISPLAY);
        //   },
        // ),
        title: Text(
          'Daily Use',
          style: AppTextStyles.semiBold(
            fontSize: 20,
            fontColor: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        actions: [
          /*IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.edit_calendar_outlined, color: AppColors.blackColor, size: 30),
            onPressed: () {
            },
          ),*/
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
