import 'package:get/get.dart';

import '../controllers/team_card_controller.dart';

class TeamCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamCardController>(
      () => TeamCardController(),
    );
  }
}
