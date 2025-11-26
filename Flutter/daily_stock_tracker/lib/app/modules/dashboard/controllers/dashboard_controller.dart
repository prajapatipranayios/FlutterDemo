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

  // DateTime? editDate;
  /// 🔥 NOW REACTIVE
  Rx<DateTime?> editDate = Rx<DateTime?>(null);

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
      createdAt: editDate.value != null
          ? editDate.value!.toIso8601String()
          : DateTime.now().toIso8601String(),
    );

    // ---------------------------
    // CASE 1: USER IS EDITING OLD ENTRY
    // ---------------------------
    if (editDate.value != null) {
      String editDay = editDate.value!.toIso8601String().substring(0, 10);

      await db.updateUsageForDate(editDay, model);
      Get.snackbar("Updated", "Record updated successfully!");

      editDate.value = null;
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

    update(); // important to refresh UI
  }

  void setEditData(StockUsageModel selectedItem) {
    txtIdliCtrl.text = selectedItem.idli;
    txtChataniCtrl.text = selectedItem.chatani;
    txtMWCtrl.text = selectedItem.meduWada;
    txtAppeCtrl.text = selectedItem.appe;
    txtsambharFullCtrl.text = selectedItem.sambhar_full;
    txtsambharHalfCtrl.text = selectedItem.sambhar_half;
    txtsambharOneFourthCtrl.text = selectedItem.sambhar_one_fourth;

    editDate.value = DateTime.parse(selectedItem.createdAt);

    update(); // 🔥 REQUIRED
  }

  void onClearPressed() {
    FocusScope.of(Get.context!).unfocus();

    clearAllFields();
    editDate.value = null; // exit edit mode

    // FORCE UNFOCUS
    Future.delayed(Duration(milliseconds: 10), () {
      FocusScope.of(Get.context!).unfocus();
    });

    update(); // important to refresh UI
    // Get.snackbar("Cleared", "Edit mode cleared. Ready for new entry.");
  }

  void clearAllFields() {
    txtIdliCtrl.clear();
    txtChataniCtrl.clear();
    txtMWCtrl.clear();
    txtAppeCtrl.clear();
    txtsambharFullCtrl.clear();
    txtsambharHalfCtrl.clear();
    txtsambharOneFourthCtrl.clear();
  }
}
