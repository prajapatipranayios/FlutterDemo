import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockEntryListController extends GetxController {
  final db = DBService();

  /// List of all stock entries (REAL DB DATA)
  RxList<StockTableModel> stockList = <StockTableModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStockEntries();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   loadStockEntries();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  /// Load all stock entries from SQLite
  Future<void> loadStockEntries() async {
    final List<StockTableModel> entries = await db.fetchAllStock();
    stockList.assignAll(entries);
    stockList.refresh();
  }

  /// Delete entry by ID
  Future<void> deleteStock(int id) async {
    await db.deleteStock(id);
    await loadStockEntries(); // Refresh list
  }

  /// Update an entry in DB
  Future<void> updateStock(StockTableModel updated) async {
    await db.updateStock(updated);
    await loadStockEntries(); // Refresh list
  }

  /// Format created date for UI
  String formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return DateFormat("EEE, dd-MMM-yyyy").format(dt);
    } catch (e) {
      return date;
    }
  }
}
