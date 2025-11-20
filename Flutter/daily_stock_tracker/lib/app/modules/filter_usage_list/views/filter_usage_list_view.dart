import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_usage_list_controller.dart';

class FilterUsageListView extends GetView<FilterUsageListController> {
  const FilterUsageListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usage List'), centerTitle: true),
      body: const Center(
        child: Text(
          'FilterUsageListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
