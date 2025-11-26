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

        body: SingleChildScrollView(
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
                const SizedBox(height: 10),

                // ---------- ROW 3 ----------
                Row(
                  children: [
                    Expanded(
                      child: buildUsageRow(
                        label: "Sambhar F :",
                        controller: controller.txtsambharFullCtrl,
                        hint: "Full",
                      ),
                    ),
                    Expanded(
                      child: buildUsageRow(
                        label: "Sambhar H :",
                        controller: controller.txtsambharHalfCtrl,
                        hint: "Half",
                        isRightPadding: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ---------- ROW 4 ----------
                Row(
                  children: [
                    Expanded(
                      child: buildUsageRow(
                        label: "Sambhar 1/4 :",
                        controller: controller.txtsambharOneFourthCtrl,
                        hint: "1/4",
                      ),
                    ),
                    Expanded(child: Text("")),
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
  }) {
    return Padding(
      padding: !isRightPadding
          ? const EdgeInsets.only(left: 16, right: 8)
          : const EdgeInsets.only(left: 8, right: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.borderColor, width: 1),
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
