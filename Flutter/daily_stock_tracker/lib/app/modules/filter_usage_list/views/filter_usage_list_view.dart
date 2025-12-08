import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/routes/app_pages.dart';
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
      appBar: AppBar(
        // LEFT BUTTON 👇
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.inventory_outlined, // Example: Stock button
            color: AppColors.blackColor,
            size: 30,
          ),
          onPressed: () {
            // YOUR LEFT ACTION HERE
            // Get.toNamed(Routes.ADD_STOCK);
            Get.toNamed(Routes.STOCK_DISPLAY);
          },
        ),
        title: const Text('Usage List'),
        centerTitle: true,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              // Icons.import_export,
              Icons.add_circle_outline_sharp,
              color: AppColors.blackColor,
              size: 35,
            ),
            onPressed: () {
              // controller.showImportExportDialog();
              Get.toNamed(Routes.DASHBOARD)?.then((value) {
                controller.getFilteredDataByWeek();
              });
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return InkWell(
                      onTap: controller.pickFromDate,
                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: Text(
                          "From: ${controller.fromDate.value}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 12),

                Expanded(
                  child: Obx(() {
                    return InkWell(
                      onTap: controller.pickToDate,
                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: Text(
                          "To: ${controller.toDate.value}",
                          style: TextStyle(fontSize: 16),
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total",
                                      style: AppTextStyles.bold(
                                        fontSize: 18,
                                        fontColor: AppColors.blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _summaryItemText(
                                        "Idli Batter",
                                        total['Idli'],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: _summaryItemText(
                                          "Chatani",
                                          total['Chatani'],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3.0),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _summaryItemText("Meduwada", total['MW']),
                                    _summaryItemText("Appe", total['Appe']),
                                  ],
                                ),
                                if ((total['S Full']?.toString().trim() ??
                                            '0') !=
                                        '0' ||
                                    (total['S Half']?.toString().trim() ??
                                            '0') !=
                                        '0' ||
                                    (total['S 1/4']?.toString().trim() ??
                                            '0') !=
                                        '0') ...[
                                  Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1.1,
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _summaryItemText(
                                        "S Full",
                                        total['S Full'],
                                      ),
                                      _summaryItemText(
                                        "S Half",
                                        total['S Half'],
                                      ),
                                      _summaryItemText("S 1/4", total['S 1/4']),
                                    ],
                                  ),
                                ],

                                if ((total['20 ltr']?.toString().trim() ??
                                        '0') !=
                                    '0') ...[
                                  Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1.1,
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Water bottle",
                                        style: AppTextStyles.bold(
                                          fontSize: 17.5,
                                          fontColor:
                                              AppColors.persianIndigoColor,
                                        ),
                                      ),
                                      _summaryItemText(
                                        "20 ltr",
                                        total['20 ltr'],
                                      ),
                                    ],
                                  ),
                                ],
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
        // onTap: () => Get.back(result: item),
        onTap:
            () => Get.toNamed(Routes.DASHBOARD, arguments: item)?.then((value) {
              controller.getFilteredDataByWeek();
            }),
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
                    print("object delete id : ${item.id!}");
                    // await Future.delayed(const Duration(milliseconds: 150));
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
              /// DAY and DATE
              Text(
                controller.formatDate(item.createdAt ?? '0'),
                style: AppTextStyles.bold(
                  fontSize: 17.5,
                  fontColor: AppColors.persianIndigoColor,
                ),
              ),
              const SizedBox(height: 6),

              /// ROW 1 -- Idli Batter, Chatani
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("Idli Batter", item.idli),
                  _itemText("Chatani", item.chatani),
                ],
              ),
              const SizedBox(height: 6.0),

              /// ROW 2 -- Meduwada, Appe
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("Meduwada", item.meduWada),
                  _itemText("Appe", item.appe),
                ],
              ),

              /// ROW 3 -- S Full, H Half, S 1/4
              if (item.sambhar_full != '0' ||
                  item.sambhar_half != '0' ||
                  item.sambhar_one_fourth != '0') ...[
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1.1,
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sambhar",
                      style: AppTextStyles.bold(
                        fontSize: 17.5,
                        fontColor: AppColors.persianIndigoColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _itemText("Full", item.sambhar_full),
                    _itemText("Half", item.sambhar_half),
                    _itemText("1/4", item.sambhar_one_fourth),
                  ],
                ),
              ],

              /// ROW 4 -- Water bottle - 20l
              if (item.water_bottle_20l != '0') ...[
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1.1,
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Water bottle",
                      style: AppTextStyles.bold(
                        fontSize: 17.5,
                        fontColor: AppColors.persianIndigoColor,
                      ),
                    ),
                    _itemText("20 ltr", item.water_bottle_20l),
                  ],
                ),
              ],
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
