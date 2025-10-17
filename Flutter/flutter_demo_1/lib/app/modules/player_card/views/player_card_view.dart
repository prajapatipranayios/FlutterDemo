import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/player_card_controller.dart';

class PlayerCardView extends GetWidget<PlayerCardController> {
  const PlayerCardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PlayerCardView'), centerTitle: true),
      body: const Center(
        child: Text(
          'PlayerCardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
