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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: SvgPicture.asset(AppAssets.backArrowIc, width: 30),
        //   onPressed: () => Get.back(),
        // ),
        title: Text(
          'Dashboard',
          style: AppTextStyles.semiBold(
            fontSize: 20,
            fontColor: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(color: AppColors.disableColor),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Daily Usage of :',
                      style: AppTextStyles.regular(
                        fontSize: 16,
                        fontColor: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: enabled
                              ? backgroundColor
                              : AppColors.textFieldBgDisable,
                          border: Border.all(
                            color: enabled
                                ? AppColors.lightBlack
                                : AppColors.borderColorDisable,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(radius),
                          ),
                        ),
                        child: TextField(
                          // controller: textController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.medium(
                            fontSize: 16,
                            fontColor: AppColors.blackColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            counterText: "",
                            hintText: 'hintText',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
