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
                child: Image.asset(ImageResources.swift, width: 30, height: 30),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(child: Icon(Icons.account_circle, size: 35)),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(child: Icon(Icons.account_circle, size: 35)),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(child: Icon(Icons.account_circle, size: 35)),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: backPress,
              child: ClipOval(child: Icon(Icons.account_circle, size: 35)),
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemCount, (index) {
            return SizedBox(
              width: itemWidth - 20,
              child: InkWell(
                onTap: backPress,
                child:
                    index < 2
                        ? ClipOval(
                          child: Image.asset(
                            ImageResources.swift,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Icon(Icons.account_circle, size: 35),
              ),
            );
          }),
        ),
      ),
    );
  }
}
