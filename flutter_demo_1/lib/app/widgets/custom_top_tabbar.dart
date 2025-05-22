import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/custom_style.dart';
import 'package:flutter_demo_1/app/core/helper/images_resources.dart';
import 'package:get/get.dart';

class TopTabBar {
  static header({backPress, title}) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(ImageResources.swift, width: 35, height: 35),
              ),
            ),
            SizedBox(width: 10),
            Expanded(child: Text(title, style: AppTextStyles.titleStyle)),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(
                  ImageResources.tournament_active,
                  width: 35,
                  height: 30,
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(
                  ImageResources.leagues_deactive,
                  width: 35,
                  height: 30,
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(
                  ImageResources.teams_active,
                  width: 35,
                  height: 30,
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(
                  ImageResources.playercard_active,
                  width: 35,
                  height: 30,
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(
                child: Image.asset(
                  ImageResources.settings_active,
                  width: 35,
                  height: 30,
                ),
              ),
            ),
            // Image.asset(ImageResources.swift, width: 30, height: 30,),
            // SizedBox(width: 50, child: Icon(Icons.account_circle, weight: 35)),
            // Icon(Icons.account_circle, weight: 30),
          ],
        ),
      ),
    );
  }

  static footer({
    required BuildContext context,
    required VoidCallback backPress,
    required String title,
  }) {
    final screenWidth = Get.width;
    final itemCount = 5;
    final itemWidth = screenWidth / itemCount;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemCount, (index) {
            return InkWell(
              onTap: backPress,
              child: Column(
                children: [
                  index < 2
                      ? ClipOval(
                        child: Image.asset(
                          ImageResources.swift,
                          width: 35,
                          height: 35,
                        ),
                      )
                      : Icon(Icons.account_circle, size: 35),
                  Text(
                    index == 0
                        ? 'Home'
                        : index == 1
                        ? 'Scheduled'
                        : index == 2
                        ? 'Chat'
                        : index == 3
                        ? 'Notification'
                        : 'More',
                    style: AppTextStyles.theamRegularStyle,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
