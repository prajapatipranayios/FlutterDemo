import 'package:get/get.dart';

import '../controllers/player_card_controller.dart';

class PlayerCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerCardController>(
      () => PlayerCardController(),
    );
  }
}
