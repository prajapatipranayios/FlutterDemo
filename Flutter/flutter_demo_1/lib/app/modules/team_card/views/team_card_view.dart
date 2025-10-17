import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/team_card_controller.dart';

class TeamCardView extends GetWidget<TeamCardController> {
  const TeamCardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TeamCardView'), centerTitle: true),
      body: const Center(
        child: Text('TeamCardView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
