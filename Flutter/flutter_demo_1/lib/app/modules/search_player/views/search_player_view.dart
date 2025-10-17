import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_player_controller.dart';

class SearchPlayerView extends GetView<SearchPlayerController> {
  const SearchPlayerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchPlayerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchPlayerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
