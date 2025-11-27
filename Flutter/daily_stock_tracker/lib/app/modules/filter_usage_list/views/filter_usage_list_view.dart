import 'package:daily_stock_tracker/app/core/helper/app_assets.dart';
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
                            controller.getFilteredDataByWeek();
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
                            controller.getFilteredDataByWeek();
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
                          // color: Colors.blue.shade200,
                          color: Colors.blue.shade100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _summaryItemText("I Batter", total['Idli']),
                                    Text(
                                      "Total",
                                      style: AppTextStyles.bold(
                                        fontSize: 18,
                                        fontColor: AppColors.blueColor,
                                      ),
                                    ),
                                    _summaryItemText(
                                      "Chatani",
                                      total['Chatani'],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _summaryItemText("Medu Wada", total['MW']),
                                    _summaryItemText("Appe", total['Appe']),
                                  ],
                                ),
                                const SizedBox(height: 6.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _summaryItemText("S Full", total['S Full']),
                                    _summaryItemText("S Half", total['S Half']),
                                    _summaryItemText("S 1/4", total['S 1/4']),
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
          ],
        ),
      ),
    );
  }

  Widget _summaryItemText(
    String label,
    dynamic value, {
    Color labelColor = AppColors.blackColor30,
    Color valueColor = AppColors.UPMaroonColor,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: AppTextStyles.bold(fontSize: 16, fontColor: labelColor),
          ),
          TextSpan(
            text: "$value",
            style: AppTextStyles.bold(fontSize: 16, fontColor: valueColor),
          ),
        ],
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
              /// DATE
              Text(
                controller.formatDate(item.createdAt),
                style: AppTextStyles.bold(
                  fontSize: 17.5,
                  fontColor: AppColors.blueColor50,
                ),
              ),
              const SizedBox(height: 6),

              /// ROW 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("I Batter", item.idli),
                  _itemText("Chatani", item.chatani),
                ],
              ),
              const SizedBox(height: 6.0),

              /// ROW 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("Medu Wada", item.meduWada),
                  _itemText("Appe", item.appe),
                ],
              ),
              const SizedBox(height: 6.0),

              /// ROW 3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("S Full", item.sambhar_full),
                  _itemText("H Half", item.sambhar_half),
                  _itemText("S 1/4", item.sambhar_one_fourth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemText(
    String label,
    dynamic value, {
    Color labelColor = AppColors.blackColor30,
    Color valueColor = AppColors.UPMaroonColor,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: AppTextStyles.bold(fontSize: 17, fontColor: labelColor),
          ),
          TextSpan(
            text: "$value",
            style: AppTextStyles.bold(fontSize: 17, fontColor: valueColor),
          ),
        ],
      ),
    );
  }
}
