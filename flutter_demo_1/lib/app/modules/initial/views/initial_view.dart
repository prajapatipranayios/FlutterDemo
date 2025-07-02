import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:flutter_demo_1/app/widgets/custom_top_tabbar.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_colors.dart';
import '../../../core/helper/custom_style.dart';
import '../../../core/helper/images_resources.dart';
import '../../../widgets/app_popup.dart';
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
                        SizedBox(width: 15),
                        Container(
                          width: (Get.width - 50) / 2,
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
                                  fontSize: 18.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  ImageResources.swift,
                                  height: ((Get.width - 50) / 2) - 15,
                                  color: AppColors.colorThemeRed,
                                ),
                              ),
                              Text(
                                AppString.myPlayerCard,
                                style: AppTextStyles.themeRegularStyle(
                                  fontSize: 18.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Text("")),
                        Container(
                          width: (Get.width - 50) / 2,
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
                                  fontSize: 18.0,
                                  fontColor: AppColors.colorBlack,
                                ),
                              ),
                              SizedBox(
                                height:
                                    q((Get.width - 50) / 2) +
                                    60, // height to accommodate image + text
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        ImageResources.swift,
                                        height: ((Get.width - 50) / 2) - 15,
                                        color: AppColors.colorThemeRed,
                                      ),
                                    ),
                                    Text(
                                      AppString.myTeams,
                                      style: AppTextStyles.themeRegularStyle(
                                        fontSize: 18.0,
                                        fontColor: AppColors.colorBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppString.myTournaments,
                      style: AppTextStyles.themeBoldStyle(
                        fontSize: 18.0,
                        fontColor: AppColors.colorBlack,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      // width: Get.width - 20,
                      // height: (Get.width / 2) - 20,
                      // padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: Container(
                        color: AppColors.colorClear,
                        height: 190,
                        child: PageView.builder(
                          controller: PageController(
                            viewportFraction:
                                0.9, // Adjust for padding/margin between pages
                          ),
                          itemCount: controller.arrTournaments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                child: Image.asset(
                                  ImageResources.swift,
                                  width: Get.width - 0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          AppString.howTheTusslyArenaWorks,
                          style: AppTextStyles.themeBoldStyle(
                            fontSize: 18.0,
                            fontColor: AppColors.colorBlack,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          color: AppColors.colorClear,
                          height: (Get.width / 3) + 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection:
                                Axis.horizontal, // 👈 horizontal scrolling
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap:
                                    () => {
                                      AppPopup.arenaInfoPopup(
                                        context: context,
                                        title: controller.arrGames[index],
                                      ),
                                    },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ), // optional spacing
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular((Get.width / 3) / 2),
                                        ), // match the outer border
                                        child: Image.asset(
                                          ImageResources.swift,
                                          height: (Get.width / 3),
                                          width: (Get.width / 3),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: 8), // Optional spacing
                                      SizedBox(
                                        width: (Get.width / 3),
                                        child: Text(
                                          controller.arrGames[index],
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyles.themeRegularStyle(
                                                fontSize: 15.0,
                                                fontColor: AppColors.colorBlack,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.arrGames.length,
                          ),
                        ),
                      ],
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
