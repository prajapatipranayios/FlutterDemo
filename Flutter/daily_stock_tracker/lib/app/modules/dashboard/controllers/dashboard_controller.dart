import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Text controllers
  var txtIdliCtrl = TextEditingController();
  var txtChataniCtrl = TextEditingController();
  var txtMWCtrl = TextEditingController();
  var txtAppeCtrl = TextEditingController();
  var txtSambharFullCtrl = TextEditingController();
  var txtSambharHalfCtrl = TextEditingController();
  var txtSambharOneFourthCtrl = TextEditingController();

  final db = DBService();

  /// Reactive edit date
  final Rx<DateTime?> editDate = Rx<DateTime?>(null);

  /// Converts blank text → "0"
  String _parseOrZero(TextEditingController ctrl) {
    final txt = ctrl.text.trim();
    return txt.isEmpty ? "0" : txt;
    // DO NOT CHANGE LOGIC, just cleaner
  }

  Future<void> onAddPressed() async {
    FocusScope.of(Get.context!).unfocus();

    final today = DateTime.now().toIso8601String().substring(0, 10);
    final selectedDate = editDate.value;

    final model = StockUsageModel(
      idli: _parseOrZero(txtIdliCtrl),
      chatani: _parseOrZero(txtChataniCtrl),
      meduWada: _parseOrZero(txtMWCtrl),
      appe: _parseOrZero(txtAppeCtrl),
      sambhar_full: _parseOrZero(txtSambharFullCtrl),
      sambhar_half: _parseOrZero(txtSambharHalfCtrl),
      sambhar_one_fourth: _parseOrZero(txtSambharOneFourthCtrl),
      createdAt:
          selectedDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );

    if (selectedDate != null) {
      // EDIT MODE
      final editDay = selectedDate.toIso8601String().substring(0, 10);

      await db.updateUsageForDate(editDay, model);
      Get.snackbar("Updated", "Record updated successfully!");
      editDate.value = null;
    } else {
      // ADD MODE
      final exists = await db.isEntryExistsForDate(today);

      if (exists) {
        await db.updateUsageForDate(today, model);
        Get.snackbar("Updated", "Today's usage has been updated.");
      } else {
        await db.insertUsage(model);
        Get.snackbar("Success", "New usage added!");
      }
    }

    clearAllFields();
    update();
  }

  void setEditData(StockUsageModel item) {
    txtIdliCtrl.text = item.idli;
    txtChataniCtrl.text = item.chatani;
    txtMWCtrl.text = item.meduWada;
    txtAppeCtrl.text = item.appe;
    txtSambharFullCtrl.text = item.sambhar_full;
    txtSambharHalfCtrl.text = item.sambhar_half;
    txtSambharOneFourthCtrl.text = item.sambhar_one_fourth;

    editDate.value = DateTime.parse(item.createdAt);
    update();
  }

  void onClearPressed() {
    FocusScope.of(Get.context!).unfocus();
    clearAllFields();
    editDate.value = null;

    Future.delayed(const Duration(milliseconds: 10), () {
      FocusScope.of(Get.context!).unfocus();
    });

    update();
  }

  void clearAllFields() {
    txtIdliCtrl.clear();
    txtChataniCtrl.clear();
    txtMWCtrl.clear();
    txtAppeCtrl.clear();
    txtSambharFullCtrl.clear();
    txtSambharHalfCtrl.clear();
    txtSambharOneFourthCtrl.clear();
  }
}
