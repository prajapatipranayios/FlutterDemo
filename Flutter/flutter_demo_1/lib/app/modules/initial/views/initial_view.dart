import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_storage.dart';
import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:flutter_demo_1/app/widgets/custom_top_tabbar.dart';
import 'package:get/get.dart';

import '../../../core/helper/app_colors.dart';
import '../../../core/helper/custom_style.dart';
import '../../../core/helper/images_resources.dart';
import '../../../routes/app_pages.dart';
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
                    !AppStorages.isLogin()
                        ? Container(
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
                              InkWell(
                                onTap:
                                    () => {
                                      print("Login Tap"),
                                      Get.toNamed(Routes.LOGIN),
                                    },
                                child: Container(
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
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap:
                                    () => {
                                      print("Login Tap"),
                                      Get.toNamed(Routes.SIGNUP),
                                    },
                                child: Container(
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
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        )
                        : SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:
                                () => {
                                  print("PlayerCard Tap"),
                                  AppStorages.setAppLogin(false),
                                  Get.offAllNamed(Routes.INITIAL),
                                },
                            child: Container(
                              //color: AppColors.colorBlue,
                              width: (Get.width - 30) / 2,
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
                                  SizedBox(height: 4),
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
                          ),
                          SizedBox(width: 10),
                          Container(
                            // color: AppColors.colorPink,
                            width: (Get.width - 30) / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  AppString.myTeams,
                                  style: AppTextStyles.themeBoldStyle(
                                    fontSize: 18.0,
                                    fontColor: AppColors.colorBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: ((Get.width) / 2), // Adjust as needed
                                  child: PageView.builder(
                                    controller: PageController(
                                      viewportFraction:
                                          1.0, // adjust size of each page
                                    ),
                                    itemCount: controller.arrTeams.length,
                                    itemBuilder: (context, index) {
                                      final team = controller.arrTeams[index];

                                      return InkWell(
                                        onTap: () {
                                          print("Team Card tap $index");
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              height:
                                                  ((Get.width - 50) / 2) - 15,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  ImageResources.swift,
                                                  color:
                                                      AppColors.colorThemeRed,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              team,
                                              style:
                                                  AppTextStyles.themeRegularStyle(
                                                    fontSize: 18.0,
                                                    fontColor:
                                                        AppColors.colorBlack,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                      color: AppColors.colorClear,
                      height: 190,
                      child: PageView.builder(
                        controller: PageController(
                          viewportFraction:
                              0.95, // Adjust for padding/margin between pages
                        ),
                        itemCount: controller.arrTournaments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            //padding: const EdgeInsets.only(right: 5.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11.0,
                            ), // gap between pages
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
                                        arrInfoTitle: [
                                          "Overview",
                                          "Lobby",
                                          "BattleArena ID Exchange",
                                          "Character Selection",
                                          "Rock Paper Scissors",
                                          "Stage Pick Ban",
                                          "Score Reporting",
                                          "Dispute System",
                                          "Chat",
                                        ],
                                        arrInfo: controller.arrSSBUInfo,
                                        arrImg: controller.arrImgSSBUInfo,
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
                    SizedBox(height: 5),
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
