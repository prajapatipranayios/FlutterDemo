import 'package:get/get.dart';

import '../controllers/stock_display_controller.dart';

class StockDisplayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockDisplayController>(
      () => StockDisplayController(),
    );
  }
}
