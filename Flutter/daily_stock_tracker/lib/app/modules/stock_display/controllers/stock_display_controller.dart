import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:get/get.dart';

class StockDisplayController extends GetxController {
  final db = DBService();

  var totalAdded = <String, int>{};
  var totalUsed = <String, int>{};
  var totalRemaining = <String, int>{};

  @override
  void onInit() {
    loadStockSummary();
    super.onInit();
  }

  Future<void> loadStockSummary() async {
    totalAdded = await db.getTotalStockAdded();
    totalUsed = await db.getTotalUsage();
    totalRemaining = await db.getStockBalance();
    update();
  }
}
