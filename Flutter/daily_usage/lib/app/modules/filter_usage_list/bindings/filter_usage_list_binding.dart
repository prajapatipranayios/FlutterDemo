import 'package:get/get.dart';

import '../controllers/filter_usage_list_controller.dart';

class FilterUsageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterUsageListController>(
      () => FilterUsageListController(),
    );
  }
}
