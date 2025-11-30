import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
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
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.filter_alt,
                color: AppColors.blackColor,
                size: 30,
              ),
              onPressed: () async {
                FocusScope.of(Get.context!).unfocus();

                controller.onClearPressed();

                final result = await Get.toNamed(Routes.FILTER_USAGE_LIST);

                if (result is StockUsageModel) {
                  controller.setEditData(result);
                }
              },
            ),
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  // ---------- ROW 1 ----------
                  Row(
                    children: [
                      Expanded(
                        child: buildUsageRow(
                          label: "Idli batter :",
                          controller: controller.txtIdliCtrl,
                          hint: "Batter",
                        ),
                      ),
                      Expanded(
                        child: buildUsageRow(
                          label: "Chatani :",
                          controller: controller.txtChataniCtrl,
                          hint: "Chatani",
                          isRightPadding: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ---------- ROW 2 ----------
                  Row(
                    children: [
                      Expanded(
                        child: buildUsageRow(
                          label: "Meduwada :",
                          controller: controller.txtMWCtrl,
                          hint: "Meduwada",
                        ),
                      ),
                      Expanded(
                        child: buildUsageRow(
                          label: "Appe :",
                          controller: controller.txtAppeCtrl,
                          hint: "Appe",
                          isRightPadding: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ---------- ROW 3 ----------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(color: Colors.grey.shade400, thickness: 1.1, height: 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Sambhar",
                        style: AppTextStyles.bold(
                          fontSize: 19,
                          fontColor: AppColors.persianIndigoColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: buildUsageRow(
                          label: "Full :",
                          controller: controller.txtSambharFullCtrl,
                          hint: "Full",
                        ),
                      ),
                      Expanded(
                        child: buildUsageRow(
                          label: "Half :",
                          controller: controller.txtSambharHalfCtrl,
                          hint: "Half",
                          isThreeOption: true,
                        ),
                      ),
                      Expanded(
                        child: buildUsageRow(
                          label: "1/4 :",
                          controller: controller.txtSambharOneFourthCtrl,
                          hint: "1/4",
                          isRightPadding: true,
                          isThreeOption: true,
                        ),
                      ),
                    ],
                  ),

                  // ---------- ROW 4 ----------
                  const SizedBox(height: 10),

                  // ---------- ROW 3 ----------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.grey.shade400, thickness: 1.1, height: 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Water bottle",
                        style: AppTextStyles.bold(
                          fontSize: 19,
                          fontColor: AppColors.persianIndigoColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: buildUsageRow(
                          label: "1 Liter :",
                          controller: controller.txtWaterOneLiterCtrl,
                          hint: "1 L",
                        ),
                      ),
                      Expanded(
                        child: buildUsageRow(
                          label: "500 ml :",
                          controller: controller.txtWater500MLCtrl,
                          hint: "500 ml",
                          isRightPadding: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ---------- ADD BUTTON ----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      return Row(
                        children: [
                          // ADD or UPDATE BUTTON
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueColor50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: controller.onAddPressed,
                                child: Text(
                                  controller.editDate.value == null
                                      ? "ADD"
                                      : "UPDATE",
                                  style: AppTextStyles.semiBold(
                                    fontSize: 18,
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          if (controller.editDate.value != null)
                            const SizedBox(width: 12),

                          // SHOW CLEAR BUTTON ONLY IN EDIT MODE
                          if (controller.editDate.value != null)
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: controller.onClearPressed,
                                  child: Text(
                                    "CLEAR",
                                    style: AppTextStyles.semiBold(
                                      fontSize: 18,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // ------------------------ Reusable Input Row Widget ----------------------
  // -------------------------------------------------------------------------

  Widget buildUsageRow({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isRightPadding = false,
    bool isThreeOption = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: isRightPadding ? 8 : (isThreeOption ? 8 : 16),
        right: isRightPadding ? 16 : 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bold(
              fontSize: 17,
              fontColor: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: AppTextStyles.semiBold(
                  fontSize: 17,
                  fontColor: AppColors.blackColor,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
