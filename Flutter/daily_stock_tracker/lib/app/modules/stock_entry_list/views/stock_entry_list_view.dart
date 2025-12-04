import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/stock_entry_list_controller.dart';

class StockEntryListView extends GetView<StockEntryListController> {
  const StockEntryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stock Entries",
          style: AppTextStyles.bold(
            fontSize: 20,
            fontColor: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<StockEntryListController>(
        builder: (_) {
          if (controller.stockList.isEmpty) {
            return const Center(child: Text("No stock entries found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.stockList.length,
            itemBuilder: (context, index) {
              final entry = controller.stockList[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Entry #${entry.id}",
                            style: AppTextStyles.bold(
                              fontSize: 16,
                              fontColor: AppColors.blackColor,
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == "edit") {
                                _openEdit(entry);
                              } else if (v == "delete") {
                                controller.deleteStock(entry.id!);
                              }
                            },
                            itemBuilder:
                                (_) => [
                                  const PopupMenuItem(
                                    value: "edit",
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: "delete",
                                    child: Text("Delete"),
                                  ),
                                ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      _row("Idli", entry.idli),
                      _row("Chatani", entry.chatani),
                      _row("Medu Wada", entry.meduWada),
                      _row("Appe", entry.appe),
                      _row("Sambhar Full", entry.sambhar_full),
                      _row("Sambhar Half", entry.sambhar_half),
                      _row("Sambhar 1/4", entry.sambhar_one_fourth),
                      _row("Bottle 1L", entry.water_bottle_1l),
                      _row("Bottle 500ml", entry.water_bottle_halfl),

                      const SizedBox(height: 10),
                      Text(
                        "Created: ${entry.createdAt.split(' ')[0]}",
                        style: AppTextStyles.regular(
                          fontSize: 13,
                          fontColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bold(
              fontSize: 14,
              fontColor: AppColors.blackColor,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bold(
              fontSize: 15,
              fontColor: AppColors.blackColor,
            ),
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
              /// DAY and DATE
              Text(
                controller.formatDate(item.createdAt),
                style: AppTextStyles.bold(
                  fontSize: 17.5,
                  fontColor: AppColors.persianIndigoColor,
                ),
              ),
              const SizedBox(height: 6),

              /// ROW 1 -- I Batter, Chatani
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemText("I Batter", item.idli),
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

              /// ROW 4 -- Water bottle - 1l, 500ml
              if (item.water_bottle_1l != '0' ||
                  item.water_bottle_halfl != '0') ...[
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
                    _itemText("1 ltr", item.water_bottle_1l),
                    _itemText("500 ml", item.water_bottle_halfl),
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

  // OPEN EDIT POPUP
  void _openEdit(StockTableModel entry) {
    Get.defaultDialog(
      title: "Edit ${entry.id}",
      content: const Text("Implement edit popup here..."),
      textConfirm: "OK",
      onConfirm: () => Get.back(),
    );
  }
}
