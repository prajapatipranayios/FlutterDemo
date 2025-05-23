import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_colors.dart';
import 'package:flutter_demo_1/app/core/helper/custom_style.dart';
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
            SizedBox(height: 10),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: AppColors.colorThemeRed,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Register for free',
                            style: AppTextStyles.themeBoldStyle(
                              fontSize: 17.0,
                              fontColor: AppColors.colorWhite,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          color: AppColors.colorWhite,
                          width: 90.0,
                          height: 30,
                          child: Center(
                            child: Text(
                              'Login',
                              style: AppTextStyles.themeMediumStyle(
                                fontSize: 13.0,
                                fontColor: AppColors.colorBlack,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          color: AppColors.colorWhite,
                          width: 90.0,
                          height: 30,
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: AppTextStyles.themeMediumStyle(
                                fontSize: 13.0,
                                fontColor: AppColors.colorBlack,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
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
