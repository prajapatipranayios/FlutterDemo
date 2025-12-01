import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStockController extends GetxController {
  // Text Input Controllers
  final txtIdli = TextEditingController();
  final txtChatani = TextEditingController();
  final txtMW = TextEditingController();
  final txtAppe = TextEditingController();
  final txtSFull = TextEditingController();
  final txtSHalf = TextEditingController();
  final txtSOneFourth = TextEditingController();
  final txtW1l = TextEditingController();
  final txtW500ml = TextEditingController();

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
    txtW1l.clear();
    txtW500ml.clear();
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
      water_bottle_1l: _zero(txtW1l),
      water_bottle_halfl: _zero(txtW500ml),
      createdAt: DateTime.now().toIso8601String(),
    );

    await db.insertStock(model);

    Get.snackbar(
      "Success",
      "Stock added successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );

    clearAll();
    update();
  }
}
