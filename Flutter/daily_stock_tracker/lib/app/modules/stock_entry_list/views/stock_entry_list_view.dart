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
