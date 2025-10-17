import 'package:get/get.dart';

import '../controllers/search_player_controller.dart';

class SearchPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPlayerController>(
      () => SearchPlayerController(),
    );
  }
}
