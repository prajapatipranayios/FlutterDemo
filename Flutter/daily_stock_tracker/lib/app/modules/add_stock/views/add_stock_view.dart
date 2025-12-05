import 'package:daily_stock_tracker/app/modules/add_stock/controllers/add_stock_controller.dart';
import 'package:daily_stock_tracker/app/routes/app_pages.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStockView extends GetView<AddStockController> {
  const AddStockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Add Stock",
          style: AppTextStyles.semiBold(
            fontSize: 20,
            fontColor: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.zero,
        //     constraints: const BoxConstraints(),
        //     icon: Icon(
        //       Icons.add_box_outlined,
        //       color: AppColors.blackColor,
        //       size: 30,
        //     ),
        //     onPressed: () async {
        //       Get.toNamed(Routes.ADD_STOCK);
        //     },
        //   ),
        // ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // ---------- Row 1 ----------
            Row(
              children: [
                Expanded(
                  child: buildStockRow(
                    label: "Idli batter :",
                    ctrl: controller.txtIdli,
                    hint: "Batter",
                  ),
                ),
                Expanded(
                  child: buildStockRow(
                    label: "Chatani :",
                    ctrl: controller.txtChatani,
                    hint: "Chatani",
                    isRightPadding: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ---------- Row 2 ----------
            Row(
              children: [
                Expanded(
                  child: buildStockRow(
                    label: "Meduwada :",
                    ctrl: controller.txtMW,
                    hint: "Meduwada",
                  ),
                ),
                Expanded(
                  child: buildStockRow(
                    label: "Appe :",
                    ctrl: controller.txtAppe,
                    hint: "Appe",
                    isRightPadding: true,
                  ),
                ),
              ],
            ),

            // ---------- Divider ----------
            const SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(thickness: 1.2, color: Colors.grey.shade400),
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
            const SizedBox(height: 8),

            // ---------- Row 3 (3 fields) ----------
            Row(
              children: [
                Expanded(
                  child: buildStockRow(
                    label: "Full :",
                    ctrl: controller.txtSFull,
                    hint: "Full",
                  ),
                ),
                Expanded(
                  child: buildStockRow(
                    label: "Half :",
                    ctrl: controller.txtSHalf,
                    hint: "Half",
                    isThreeOption: true,
                  ),
                ),
                Expanded(
                  child: buildStockRow(
                    label: "1/4 :",
                    ctrl: controller.txtSOneFourth,
                    hint: "1/4",
                    isRightPadding: true,
                    isThreeOption: true,
                  ),
                ),
              ],
            ),

            // ---------- Divider ----------
            const SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(thickness: 1.2, color: Colors.grey.shade400),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Water Bottle",
                  style: AppTextStyles.bold(
                    fontSize: 19,
                    fontColor: AppColors.persianIndigoColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ---------- Row 4 ----------
            Row(
              children: [
                Expanded(
                  child: buildStockRow(
                    label: "1 Liter :",
                    ctrl: controller.txtW1l,
                    hint: "1 L",
                  ),
                ),
                Expanded(
                  child: buildStockRow(
                    label: "500 ml :",
                    ctrl: controller.txtW500ml,
                    hint: "500 ml",
                    isRightPadding: true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ---------- SAVE BUTTON ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: controller.saveStock,
                  child: Text(
                    "SAVE STOCK",
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

  // ------------------------------------------------------------------
  // Reusable input widget (same as Dashboard)
  // ------------------------------------------------------------------
  Widget buildStockRow({
    required String label,
    required TextEditingController ctrl,
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
                controller: ctrl,
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
