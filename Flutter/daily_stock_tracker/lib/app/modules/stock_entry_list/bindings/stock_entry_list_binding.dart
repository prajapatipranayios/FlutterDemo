import 'package:get/get.dart';

import '../controllers/stock_entry_list_controller.dart';

class StockEntryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockEntryListController>(
      () => StockEntryListController(),
    );
  }
}
