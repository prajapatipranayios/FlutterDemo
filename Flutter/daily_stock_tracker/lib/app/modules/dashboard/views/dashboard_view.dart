import 'package:daily_stock_tracker/app/routes/app_pages.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.filter_alt,
                color: AppColors.blackColor,
                size: 30,
              ),
              onPressed: () {
                Get.toNamed(Routes.FILTER_USAGE_LIST);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            /// =============== Idli =================
            buildUsageRow(
              label: "Idli batter :",
              controller: controller.txtIdliCtrl,
              hint: "No of batter",
            ),
            SizedBox(height: 10),

            /// =============== Chatani =================
            buildUsageRow(
              label: "Chatani :",
              controller: controller.txtChataniCtrl,
              hint: "No of Chatani",
            ),
            SizedBox(height: 10),

            /// =============== Meduwada =================
            buildUsageRow(
              label: "Meduwada :",
              controller: controller.txtMWCtrl,
              hint: "No of MW",
            ),
            SizedBox(height: 10),

            /// =============== Appe =================
            buildUsageRow(
              label: "Appe :",
              controller: controller.txtAppeCtrl,
              hint: "No of Appe",
            ),

            SizedBox(height: 20),

            /// =============== ADD BUTTON =================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ), // LEFT + RIGHT
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    controller.onAddPressed();
                  },
                  child: Text(
                    "ADD",
                    style: AppTextStyles.semiBold(
                      fontSize: 18,
                      fontColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUsageRow({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 95.0,
            child: Text(
              label,
              style: AppTextStyles.regular(
                fontSize: 16,
                fontColor: AppColors.blackColor,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40.0,
              decoration: BoxDecoration(
                color: AppColors.white20,
                border: Border.all(
                  color: AppColors.borderColorDisable,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
