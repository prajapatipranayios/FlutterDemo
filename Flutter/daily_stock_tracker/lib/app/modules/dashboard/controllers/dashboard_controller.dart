import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var txtIdliCtrl = TextEditingController();
  var txtChataniCtrl = TextEditingController();
  var txtMWCtrl = TextEditingController();
  var txtAppeCtrl = TextEditingController();

  final db = DBService();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddPressed() async {
    FocusScope.of(Get.context!).unfocus();

    String today = DateTime.now().toIso8601String().substring(0, 10);
    // format → YYYY-MM-DD

    /// 🔍 Check if entry already exists for today
    bool exists = await db.isEntryExistsForDate(today);

    if (exists) {
      Get.snackbar(
        "Duplicate Entry",
        "Entry for today already exists",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    /// 🔢 Convert empty inputs to zero
    final model = StockUsageModel(
      idli: (txtIdliCtrl.text.trim().isEmpty) ? "0" : txtIdliCtrl.text.trim(),
      chatani: (txtChataniCtrl.text.trim().isEmpty)
          ? "0"
          : txtChataniCtrl.text.trim(),
      meduWada: (txtMWCtrl.text.trim().isEmpty) ? "0" : txtMWCtrl.text.trim(),
      appe: (txtAppeCtrl.text.trim().isEmpty) ? "0" : txtAppeCtrl.text.trim(),
      createdAt: DateTime.now().toIso8601String(),
    );

    /// 👉 Save to database
    await db.insertUsage(model);

    Get.snackbar(
      "Success",
      "Data saved successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );

    /// Clear fields
    txtIdliCtrl.clear();
    txtChataniCtrl.clear();
    txtMWCtrl.clear();
    txtAppeCtrl.clear();
  }
}
