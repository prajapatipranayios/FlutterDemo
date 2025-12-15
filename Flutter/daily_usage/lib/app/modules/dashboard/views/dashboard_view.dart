
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';
import '../../../utilities/date_utils.dart';
import '../../../utilities/snackbar_helper.dart';
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
          // LEFT BUTTON 👇
          // leading: IconButton(
          //   padding: EdgeInsets.zero,
          //   constraints: const BoxConstraints(),
          //   icon: Icon(
          //     Icons.inventory_outlined, // Example: Stock button
          //     color: AppColors.blackColor,
          //     size: 30,
          //   ),
          //   onPressed: () {
          //     // YOUR LEFT ACTION HERE
          //     // Get.toNamed(Routes.ADD_STOCK);
          //     Get.toNamed(Routes.STOCK_DISPLAY);
          //   },
          // ),
          title: Text(
            'Daily Use',
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
              icon: Icon(Icons.edit_calendar_outlined, color: AppColors.blackColor, size: 30),
              onPressed: () {
                if (!controller.isValid.value) {
                  _openToEnterPassword();
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
                  // ---------- Date + Divider ----------
                  Obx(() {
                    if (!controller.isValid.value) {
                      return SizedBox.shrink(); // hide everything
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 4),
                          child: Row(
                            children: [
                              Text(
                                "Date: ",
                                style: AppTextStyles.bold(
                                  fontSize: 19,
                                  fontColor: AppColors.persianIndigoColor,
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: controller.pickToDate,
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(right: 16),
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      controller.usageDate.value,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            color: Colors.grey.shade400,
                            thickness: 1.1,
                            height: 20,
                          ),
                        ),

                        const SizedBox(height: 3),
                      ],
                    );
                  }),

                  // ---------- ROW 1 ----------
                  Row(
                    children: [
                      Expanded(
                        child: buildUsageMultiRow(
                          label: "Idli batter :",
                          controller: controller.txtIdliCtrl,
                          hint: "Batter",
                        ),
                      ),
                      Expanded(
                        child: buildUsageMultiRow(
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
                        child: buildUsageMultiRow(
                          label: "Meduwada :",
                          controller: controller.txtMWCtrl,
                          hint: "Meduwada",
                        ),
                      ),
                      Expanded(
                        child: buildUsageMultiRow(
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
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.1,
                      height: 20,
                    ),
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
                        child: buildUsageMultiRow(
                          label: "Full :",
                          controller: controller.txtSambharFullCtrl,
                          hint: "Full",
                        ),
                      ),
                      Expanded(
                        child: buildUsageMultiRow(
                          label: "Half :",
                          controller: controller.txtSambharHalfCtrl,
                          hint: "Half",
                          isThreeOption: true,
                        ),
                      ),
                      Expanded(
                        child: buildUsageMultiRow(
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
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.1,
                      height: 20,
                    ),
                  ),

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
                          controller: controller.txtWater20LiterCtrl,
                          hint: "20 L",
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
                                      ? "Add Usage"
                                      : "Update",
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

  Widget buildUsageMultiRow({
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

  void _openToEnterPassword() {
    // Create temporary editing controllers
    // final txtIdli = TextEditingController(text: entry.idli);

    Get.dialog(
      AlertDialog(
        title: Text(
          "Enter Password to edit date",
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w400,
            color: AppColors.fireEngineRedColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ), // 🔥 reduced padding
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: 45,        // 👈 FIXED HEIGHT
                  child: TextField(
                    controller: controller.txtPasswordCtrl,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.semiBold(
                      fontSize: 17,
                      fontColor: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                      ),

                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
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
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("CANCEL")),

          TextButton(
            onPressed: () async {
              if (DateUtilsHelper.generateCodedPin() == controller.txtPasswordCtrl.text) {
                controller.isValid.value = true;
                controller.txtPasswordCtrl.clear();
                Get.back();
              }
              else {
                SnackbarHelper.show(Get.context!,type: SnackbarType.error, "Wrong Password.");
              }
              // SnackbarHelper.show(Get.context!,type: SnackbarType.success, "Record updated successfully.");
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }
}
