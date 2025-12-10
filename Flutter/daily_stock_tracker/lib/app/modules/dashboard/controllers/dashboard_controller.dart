import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:daily_stock_tracker/app/widgets/utilities/snackbar_helper.dart';
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
  var txtWater20LiterCtrl = TextEditingController();

  late StockUsageModel tempData;

  final usageDate = "".obs;

  final db = DBService();

  /// Reactive edit date
  final Rx<DateTime?> editDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    usageDate.value = _format(now); // Today

    if (Get.arguments != null) {
      tempData = StockUsageModel();
      tempData = Get.arguments;
      setEditData(tempData);
    }
  }

  /// Converts blank text → "0"
  String _parseOrZero(TextEditingController ctrl) {
    final txt = ctrl.text.trim();
    return txt.isEmpty ? "0" : txt;
    // DO NOT CHANGE LOGIC, just cleaner
  }

  Future<void> onAddPressed() async {
    FocusScope.of(Get.context!).unfocus();

    final today = usageDate.value;
    final selectedDate = editDate.value;

    final model = StockUsageModel(
      idli: _parseOrZero(txtIdliCtrl),
      chatani: _parseOrZero(txtChataniCtrl),
      meduWada: _parseOrZero(txtMWCtrl),
      appe: _parseOrZero(txtAppeCtrl),
      sambhar_full: _parseOrZero(txtSambharFullCtrl),
      sambhar_half: _parseOrZero(txtSambharHalfCtrl),
      sambhar_one_fourth: _parseOrZero(txtSambharOneFourthCtrl),
      water_bottle_20l: _parseOrZero(txtWater20LiterCtrl),
      createdAt: selectedDate?.toIso8601String() ?? today,
    );

    if (selectedDate != null) {
      // EDIT MODE
      final editDay = selectedDate.toIso8601String().substring(0, 10);

      await db.updateUsageForDate(editDay, model);
      // Get.snackbar("Updated", "Record updated successfully!");
      SnackbarHelper.show(Get.context!,type: SnackbarType.success, "Record updated successfully.");
      editDate.value = null;
    } else {
      // ADD MODE
      final exists = await db.isEntryExistsForDate(today);

      if (exists) {
        await db.updateUsageForDate(today, model);
        // Get.snackbar("Updated", "Today's usage has been updated.");
        SnackbarHelper.show(Get.context!,type: SnackbarType.warning, "Today's usage has been updated.");
      } else {
        await db.insertUsage(model);
        SnackbarHelper.show(Get.context!,type: SnackbarType.success, "New usage added.");
      }
    }

    clearAllFields();
    update();
  }


  void setEditData(StockUsageModel item) {
    txtIdliCtrl.text = item.idli ?? '0';
    txtChataniCtrl.text = item.chatani ?? '0';
    txtMWCtrl.text = item.meduWada ?? '0';
    txtAppeCtrl.text = item.appe ?? '0';
    txtSambharFullCtrl.text = item.sambhar_full ?? '0';
    txtSambharHalfCtrl.text = item.sambhar_half ?? '0';
    txtSambharOneFourthCtrl.text = item.sambhar_one_fourth ?? '0';
    txtWater20LiterCtrl.text = item.water_bottle_20l ?? '0';

    editDate.value = DateTime.parse(item.createdAt ?? '0');

    if (item.createdAt != null && item.createdAt!.isNotEmpty) {
      final date = DateTime.parse(item.createdAt!);

      /// Set edit date for saving logic
      editDate.value = date;

      /// Set usageDate to show on screen
      usageDate.value = _format(date);
    }

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
    txtWater20LiterCtrl.clear();
  }

  String _format(DateTime dt) => dt.toIso8601String().split("T").first;

  Future<void> pickToDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(), // default → today
      firstDate: DateTime(2020), // allow any past date
      lastDate: DateTime.now(), // max limit → today
    );

    if (picked != null) {
      usageDate.value = _format(picked);
    }
  }
}
