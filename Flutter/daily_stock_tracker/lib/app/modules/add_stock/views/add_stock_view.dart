import 'package:daily_stock_tracker/app/modules/add_stock/controllers/add_stock_controller.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // ---------- Row 1 ----------
            Row(
              children: [
                Expanded(
                  child: buildStockMultiRow(
                    label: "Idli batter :",
                    ctrl: controller.txtIdli,
                    hint: "Batter",
                  ),
                ),
                Expanded(
                  child: buildStockMultiRow(
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
                  child: buildStockMultiRow(
                    label: "Meduwada :",
                    ctrl: controller.txtMW,
                    hint: "Meduwada",
                  ),
                ),
                Expanded(
                  child: buildStockMultiRow(
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
                  child: buildStockMultiRow(
                    label: "Full :",
                    ctrl: controller.txtSFull,
                    hint: "Full",
                  ),
                ),
                Expanded(
                  child: buildStockMultiRow(
                    label: "Half :",
                    ctrl: controller.txtSHalf,
                    hint: "Half",
                    isThreeOption: true,
                  ),
                ),
                Expanded(
                  child: buildStockMultiRow(
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

            // ---------- Row 4 ----------
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 4),
                  child: Text(
                    "Water bottle",
                    style: AppTextStyles.bold(
                      fontSize: 19,
                      fontColor: AppColors.persianIndigoColor,
                    ),
                  ),
                ),
                Expanded(
                  child: buildUsageMonoRow(
                    label: "20 Liter :",
                    controller: controller.txtW20l,
                    hint: "20 L",
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
  Widget buildStockMultiRow({
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsageMonoRow({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bold(
              fontSize: 17,
              fontColor: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(left: 8),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
