import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // leading: IconButton(
        //   icon: SvgPicture.asset(AppAssets.backArrowIc, width: 30),
        //   onPressed: () => Get.back(),
        // ),
        title: Text(
          'Dashboard',
          style: AppTextStyles.semiBold(
            fontSize: 20,
            fontColor: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'create_custom_workout_desc',
            style: AppTextStyles.regular(
              fontSize: 16,
              fontColor: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textFieldBgDisable,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text('data'),
          ),
        ],
      ),
    );
  }
}
