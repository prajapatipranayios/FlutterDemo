import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_usage_list_controller.dart';

class FilterUsageListView extends GetView<FilterUsageListController> {
  const FilterUsageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usage List'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                /// ======= MONTH DROPDOWN SECTION =======
                Expanded(
                  child: Obx(() {
                    return Container(
                      height: 45.0,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedMonthFilter.value,
                          items: controller.filterMonths
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedMonthFilter.value = value!;
                          },
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16.0),

                /// ======= YEAR DROPDOWN SECTION =======
                Expanded(
                  child: Obx(() {
                    return Container(
                      height: 45.0,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedYearFilter.value,
                          items: controller.filterYears
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedYearFilter.value = value!;
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(height: 20),

            /// ==== LIST OF FILTERED RESULTS ====
            Expanded(
              child: Obx(() {
                if (controller.weeklyGroups.isEmpty) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.weeklyGroups.length,
                  itemBuilder: (_, weekIndex) {
                    final group = controller.weeklyGroups[weekIndex];
                    final total = group["total"];
                    final items = group["items"];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // WEEK LABEL
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            group["weekLabel"],
                            style: AppTextStyles.bold(
                              fontSize: 20,
                              fontColor: AppColors.blueColor,
                            ),
                          ),
                        ),

                        // WEEK SUMMARY CARD
                        Card(
                          color: Colors.blue.shade50,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Idli: ${total['Idli']}"),
                                    Text(
                                      "Total",
                                      style: AppTextStyles.bold(
                                        fontSize: 20,
                                        fontColor: AppColors.blueColor,
                                      ),
                                    ),
                                    Text("Chatani: ${total['Chatani']}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("MW: ${total['MW']}"),
                                    Text("Appe: ${total['Appe']}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("S Full: ${total['S Full']}"),
                                    Text("S Half: ${total['S Half']}"),
                                    Text("S 1/4: ${total['S 1/4']}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // DAILY ITEMS LIST
                        ...items.map((item) => _buildDailyCard(item)).toList(),

                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }),
            ),
            /*Expanded(
              child: Obx(() {
                if (controller.usageList.isEmpty) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.usageList.length,
                  itemBuilder: (context, index) {
                    final item = controller.usageList[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          Get.back(result: item);
                        },
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Delete?"),
                              content: const Text(
                                "Do you want to delete this entry?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.back();
                                    await Future.delayed(
                                      const Duration(milliseconds: 150),
                                    );
                                    controller.deleteRecord(item.id!);
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        },

                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ------------------------ DATE ------------------------
                              Text(
                                "Date: ${controller.formatDate(item.createdAt)}",
                                style: AppTextStyles.bold(
                                  fontSize: 19,
                                  fontColor: AppColors.blueColor,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // ------------------------ ROW 1 ------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _itemText("Idli", item.idli),
                                  _itemText("Chatani", item.chatani),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // ------------------------ ROW 2 ------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _itemText("MW", item.meduWada),
                                  _itemText("Appe", item.appe),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // ------------------------ ROW 3 ------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _itemText("S Full", item.sambhar_full),
                                  _itemText("S Half", item.sambhar_half),
                                  _itemText("S 1/4", item.sambhar_one_fourth),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildDailyCard(StockUsageModel item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () => Get.back(result: item),
        // 👇 LONG PRESS DELETE
        onLongPress: () {
          Get.dialog(
            AlertDialog(
              title: const Text("Delete?"),
              content: const Text("Do you want to delete this entry?"),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () async {
                    Get.back();
                    await Future.delayed(const Duration(milliseconds: 150));
                    controller.deleteRecord(item.id!);
                  },
                  child: const Text("Yes"),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.formatDate(item.createdAt),
                style: AppTextStyles.bold(
                  fontSize: 18,
                  fontColor: AppColors.blueColor50,
                ),
              ),
              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("Idli", item.idli),
                  _itemText("Chatani", item.chatani),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("MW", item.meduWada),
                  _itemText("Appe", item.appe),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("S Full", item.sambhar_full),
                  _itemText("H Full", item.sambhar_half),
                  _itemText("S 1/4", item.sambhar_one_fourth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemText(String label, dynamic value) {
    return Expanded(
      child: Text(
        "$label: $value",
        style: AppTextStyles.bold(
          fontSize: 17,
          fontColor: AppColors.blackColor,
        ),
      ),
    );
  }
}
