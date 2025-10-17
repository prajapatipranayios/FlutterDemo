import 'package:flutter/material.dart';
import 'package:flutter_demo_1/app/core/helper/app_colors.dart';
import 'package:flutter_demo_1/app/core/helper/custom_style.dart';
import 'package:flutter_demo_1/app/core/helper/images_resources.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class TopTabBar {
  static header({required VoidCallback backPress, required String title}) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(Routes.INITIAL),
              child: ClipOval(
                child: Image.asset(ImageResources.swift, width: 35, height: 35),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.themeBoldStyle(
                  fontSize: 21.0,
                  fontColor: AppColors.colorBlack,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Header navigation icons
            //_headerIcon(ImageResources.tournament_active, Routes.TOURNAMENT),
            _headerIcon(ImageResources.tournament_active, Routes.INITIAL),
            //_headerIcon(ImageResources.leagues_deactive, Routes.LEAGUE),
            _headerIcon(ImageResources.leagues_deactive, Routes.INITIAL),
            //_headerIcon(ImageResources.teams_active, Routes.TEAM),
            _headerIcon(ImageResources.teams_active, Routes.INITIAL),
            //_headerIcon(ImageResources.playercard_active, Routes.PLAYER_CARD),
            _headerIcon(ImageResources.playercard_active, Routes.INITIAL),
            //_headerIcon(ImageResources.settings_active, Routes.SETTINGS),
            _headerIcon(ImageResources.settings_active, Routes.INITIAL),
          ],
        ),
      ),
    );
  }

  static Widget _headerIcon(String imagePath, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipOval(child: Image.asset(imagePath, width: 35, height: 30)),
      ),
    );
  }

  static footer({
    required BuildContext context,
    required VoidCallback backPress,
    required String title,
  }) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _footerItem(
              ImageResources.home_active,
              'Home',
              Routes.INITIAL,
              isHome: true,
            ),
            _footerItem(
              ImageResources.schedule_deactive,
              'Scheduled',
              //Routes.SCHEDULE,
              Routes.LOGIN,
            ),
            //_footerItem(ImageResources.chat_active, 'Chat', Routes.CHAT),
            _footerItem(ImageResources.chat_active, 'Chat', Routes.INITIAL),
            _footerItem(
              ImageResources.notification_active,
              'Notification',
              //Routes.NOTIFICATIONS,
              Routes.INITIAL,
            ),
            //_footerItem(ImageResources.more_active, 'More', Routes.MORE),
            _footerItem(ImageResources.more_active, 'More', Routes.SIGNUP),
          ],
        ),
      ),
    );
  }

  static Widget _footerItem(
    String imagePath,
    String label,
    String route, {
    bool isHome = false,
  }) {
    return InkWell(
      onTap: () {
        if (isHome) {
          // Go to home and clear navigation stack
          Get.offAllNamed(route);
        } else {
          // Go to other pages without clearing stack
          Get.toNamed(route);
        }
      },
      child: Column(
        children: [
          Image.asset(imagePath, width: 35, height: 35),
          Text(
            label,
            style: AppTextStyles.themeRegularStyle(
              fontSize: 14.0,
              fontColor: AppColors.colorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
