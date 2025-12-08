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

  void _openEdit(StockTableModel entry) {
    // Create temporary editing controllers
    final txtIdli = TextEditingController(text: entry.idli);
    final txtChatani = TextEditingController(text: entry.chatani);
    final txtMW = TextEditingController(text: entry.meduWada);
    final txtAppe = TextEditingController(text: entry.appe);
    final txtSFull = TextEditingController(text: entry.sambhar_full);
    final txtSHalf = TextEditingController(text: entry.sambhar_half);
    final txtSOneFourth = TextEditingController(text: entry.sambhar_one_fourth);
    final txtW20l = TextEditingController(text: entry.water_bottle_20l);

    Get.dialog(
      AlertDialog(
        title: Text("Edit Record #${entry.id}"),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ), // 🔥 reduced padding
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _field("Idli", txtIdli)),
                  const SizedBox(width: 8),
                  Expanded(child: _field("Chatani", txtChatani)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _field("Medu Wada", txtMW)),
                  const SizedBox(width: 8),
                  Expanded(child: _field("Appe", txtAppe)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _field("S Full", txtSFull)),
                  SizedBox(width: 8),
                  Expanded(child: _field("S Half", txtSHalf)),
                  SizedBox(width: 8),
                  Expanded(child: _field("S 1/4", txtSOneFourth)),
                ],
              ),
              Row(children: [Expanded(child: _field("20 Litre", txtW20l))]),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("CANCEL")),

          TextButton(
            onPressed: () async {
              // Create updated model
              final updated = StockTableModel(
                id: entry.id,
                idli: txtIdli.text.trim(),
                chatani: txtChatani.text.trim(),
                meduWada: txtMW.text.trim(),
                appe: txtAppe.text.trim(),
                sambhar_full: txtSFull.text.trim(),
                sambhar_half: txtSHalf.text.trim(),
                sambhar_one_fourth: txtSOneFourth.text.trim(),
                water_bottle_20l: txtW20l.text.trim(),
                createdAt: entry.createdAt, // keep original date
              );

              // Call update function
              await Get.find<StockEntryListController>().updateStock(updated);

              Get.back();
              Get.snackbar(
                "Success",
                "Record updated successfully",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  /// Reusable TextField inside popup
  /*Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }*/

  Widget _field(
    String label,
    TextEditingController c, {
    double height = 40,
    double fontSize = 16,
    Color textColor = Colors.black,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 4),
    Color borderColor = Colors.grey,
  }) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: TextField(
          controller: c,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: fontSize - 2,
              color: Colors.grey.shade900,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.blue.shade400, width: 1.8),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  /*Widget _field(String label, TextEditingController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: TextField(
            controller: c,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }*/
}
