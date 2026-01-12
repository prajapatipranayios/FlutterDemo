
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/StockArrivalModel.dart';
import '../../../core/services/db_service.dart';
import '../../../utilities/snackbar_helper.dart';

class AddStockController extends GetxController {
  // Text Input Controllers
  final txtIdli = TextEditingController();
  final txtChatani = TextEditingController();
  final txtMW = TextEditingController();
  final txtAppe = TextEditingController();
  final txtSFull = TextEditingController();
  final txtSHalf = TextEditingController();
  final txtSOneFourth = TextEditingController();

  final db = DBService();

  String _zero(TextEditingController c) =>
      c.text.trim().isEmpty ? "0" : c.text.trim();

  void clearAll() {
    txtIdli.clear();
    txtChatani.clear();
    txtMW.clear();
    txtAppe.clear();
    txtSFull.clear();
    txtSHalf.clear();
    txtSOneFourth.clear();
  }

  Future<void> saveStock() async {
    final model = StockTableModel(
      idli: _zero(txtIdli),
      chatani: _zero(txtChatani),
      meduWada: _zero(txtMW),
      appe: _zero(txtAppe),
      sambhar_full: _zero(txtSFull),
      sambhar_half: _zero(txtSHalf),
      sambhar_one_fourth: _zero(txtSOneFourth),
      createdAt: DateTime.now().toIso8601String(),
    );

    await db.insertStock(model);

    SnackbarHelper.show(Get.context!,type: SnackbarType.success, "Stock added successfully.");

    clearAll();
    update();
  }
}
