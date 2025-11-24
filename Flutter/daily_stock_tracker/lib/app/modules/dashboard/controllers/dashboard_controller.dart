import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var txtIdliCtrl = TextEditingController();
  var txtChataniCtrl = TextEditingController();
  var txtMWCtrl = TextEditingController();
  var txtAppeCtrl = TextEditingController();
  var txtsambharFullCtrl = TextEditingController();
  var txtsambharHalfCtrl = TextEditingController();
  var txtsambharOneFourthCtrl = TextEditingController();

  final db = DBService();

  DateTime? editDate;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if (Get.arguments != null && Get.arguments is StockUsageModel) {
      final selectedItem = Get.arguments as StockUsageModel;

      txtIdliCtrl.text = selectedItem.idli;
      txtChataniCtrl.text = selectedItem.chatani;
      txtMWCtrl.text = selectedItem.meduWada;
      txtAppeCtrl.text = selectedItem.appe;
      txtsambharFullCtrl.text = selectedItem.sambhar_full;
      txtsambharHalfCtrl.text = selectedItem.sambhar_half;
      txtsambharOneFourthCtrl.text = selectedItem.sambhar_one_fourth;

      editDate = DateTime.parse(selectedItem.createdAt);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddPressed() async {
    FocusScope.of(Get.context!).unfocus();

    String today = DateTime.now().toIso8601String().substring(0, 10);

    final model = StockUsageModel(
      idli: txtIdliCtrl.text.trim().isEmpty ? "0" : txtIdliCtrl.text.trim(),
      chatani: txtChataniCtrl.text.trim().isEmpty
          ? "0"
          : txtChataniCtrl.text.trim(),
      meduWada: txtMWCtrl.text.trim().isEmpty ? "0" : txtMWCtrl.text.trim(),
      appe: txtAppeCtrl.text.trim().isEmpty ? "0" : txtAppeCtrl.text.trim(),
      sambhar_full: txtsambharFullCtrl.text.trim().isEmpty
          ? "0"
          : txtsambharFullCtrl.text.trim(),
      sambhar_half: txtsambharHalfCtrl.text.trim().isEmpty
          ? "0"
          : txtsambharHalfCtrl.text.trim(),
      sambhar_one_fourth: txtsambharOneFourthCtrl.text.trim().isEmpty
          ? "0"
          : txtsambharOneFourthCtrl.text.trim(),
      createdAt: DateTime.now().toIso8601String(),
    );

    // ---------------------------
    // CASE 1: USER IS EDITING OLD ENTRY
    // ---------------------------
    if (editDate != null) {
      String editDay = editDate!.toIso8601String().substring(0, 10);

      await db.updateUsageForDate(editDay, model);
      Get.snackbar("Updated", "Record updated successfully!");

      editDate = null; // reset edit mode
    }
    // ---------------------------
    // CASE 2: NORMAL ADD LOGIC
    // ---------------------------
    else {
      bool exists = await db.isEntryExistsForDate(today);

      if (exists) {
        await db.updateUsageForDate(today, model);
        Get.snackbar("Updated", "Today's usage has been updated.");
      } else {
        await db.insertUsage(model);
        Get.snackbar("Success", "New usage added!");
      }
    }

    // Clear fields
    txtIdliCtrl.clear();
    txtChataniCtrl.clear();
    txtMWCtrl.clear();
    txtAppeCtrl.clear();
    txtsambharFullCtrl.clear();
    txtsambharHalfCtrl.clear();
    txtsambharOneFourthCtrl.clear();
  }
}
