import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_colors.dart';
import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:flutter_demo_1/app/core/helper/custom_style.dart';
import 'package:flutter_demo_1/app/core/helper/images_resources.dart';
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
              title: AppString.tussly,
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
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
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(13.5),
                              ),
                            ),
                            width: 90.0,
                            height: 27,
                            child: Center(
                              child: Text(
                                'Login',
                                style: AppTextStyles.themeMediumStyle(
                                  fontSize: 14.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(13.5),
                              ),
                            ),
                            width: 90.0,
                            height: 27,
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: AppTextStyles.themeMediumStyle(
                                  fontSize: 14.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: Get.width / 2,
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 5,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppString.myPlayerCard,
                                style: AppTextStyles.themeBoldStyle(
                                  fontSize: 17.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  ImageResources.swift,
                                  height: (Get.width / 2) - 15,
                                  color: AppColors.colorThemeRed,
                                ),
                              ),
                              Text(AppString.myPlayerCard),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width / 2,
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppString.myTeams,
                                style: AppTextStyles.themeBoldStyle(
                                  fontSize: 17.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  ImageResources.swift,
                                  height: (Get.width / 2) - 15,
                                  color: AppColors.colorThemeRed,
                                ),
                              ),
                              Text(AppString.myTeams),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: Get.width - 20,
                      // height: (Get.width / 2) - 20,
                      padding: EdgeInsets.only(left: 10, right: 5, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppString.myPlayerCard,
                            style: AppTextStyles.themeBoldStyle(
                              fontSize: 17.0,
                              fontColor: AppColors.colorBlack,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ), // match the outer border
                            child: Image.asset(
                              ImageResources.swift,
                              height: (Get.width / 2) - 10,
                              width: Get.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:
                          Axis.horizontal, // 👈 horizontal scrolling
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ), // optional spacing
                          child: Column(
                            children: [
                              Image.asset(
                                ImageResources.swift,
                                width: 150.0,
                                height: 150.0,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
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
