import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  var arrTabbarTop = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
  ];

  var arrTabbarBottom = ['Home', 'Scheduled', 'Chat', 'Notification', 'More'];

  var arrGames = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
    AppString.valorantName,
  ];

  var arrTournaments = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
    AppString.valorantName,
  ];

  List<String> teams = ['Team A', 'Team B', 'Team C', 'Team D'];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
