import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
import 'package:daily_stock_tracker/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';
import '../controllers/stock_entry_list_controller.dart';

class StockEntryListView extends GetWidget<StockEntryListController> {
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
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.add_box_outlined,
              color: AppColors.blackColor,
              size: 35,
            ),
            onPressed: () {
              Get.toNamed(Routes.ADD_STOCK)?.then((value) {
                controller.loadStockEntries();
              });
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: controller.stockList.length,
          itemBuilder: (context, index) {
            // final entry = controller.stockList[index];
            return Padding(
              padding: const EdgeInsets.all(4),
              child: _buildStockCard(index),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStockCard(/*StockTableModel item*/ int index) {
    var item = controller.stockList[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Get.back();
        },
        /*onLongPress: () {
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
                    // controller.deleteRecord(item.id!);
                  },
                  child: const Text("Yes"),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },*/
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// DAY and DATE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatDate(item.createdAt),
                    style: AppTextStyles.bold(
                      fontSize: 17.5,
                      fontColor: AppColors.persianIndigoColor,
                    ),
                  ),
                  Text(
                    "Id #${item.id}",
                    style: AppTextStyles.bold(
                      fontSize: 15.5,
                      fontColor: AppColors.blackColor,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (option) {
                      if (option == "edit") {
                        _openEdit(item);
                        print("Selected Edit Stock id: ${item.id}");
                      } else if (option == "delete") {
                        controller.deleteStock(item.id!);
                        print("Selected Delete Stock id: ${item.id}");
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
