import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
import 'package:get/get.dart';

class StockEntryListController extends GetxController {
  RxList<StockTableModel> stockList = <StockTableModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStockEntries();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Load from database later
  void loadStockEntries() async {
    // Example dummy data
    stockList.value = [
      StockTableModel(
        id: 1,
        idli: "50",
        chatani: "20",
        meduWada: "15",
        appe: "10",
        sambhar_full: "30",
        sambhar_half: "20",
        sambhar_one_fourth: "10",
        water_bottle_1l: "5",
        water_bottle_halfl: "12",
        createdAt: DateTime.now().toString(),
      ),
    ];
  }

  void deleteStock(int id) {
    stockList.removeWhere((e) => e.id == id);
    update();
  }

  void updateStock(StockTableModel updated) {
    final index = stockList.indexWhere((e) => e.id == updated.id);
    if (index != -1) {
      stockList[index] = updated;
      update();
    }
  }
}
