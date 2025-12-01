import 'package:daily_stock_tracker/app/modules/stock_display/controllers/stock_display_controller.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDisplayView extends GetView<StockDisplayController> {
  const StockDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stock Overview",
          style: AppTextStyles.bold(
            fontSize: 20,
            fontColor: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),

      body: GetBuilder<StockDisplayController>(
        builder: (_) {
          if (controller.totalAdded.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                // ===================== TOTAL ADDED =====================
                _sectionHeader("Total Stock Added"),
                _summaryCard(controller.totalAdded, Colors.blue.shade100),

                const SizedBox(height: 12),

                // ===================== TOTAL USED =====================
                _sectionHeader("Total Used"),
                _summaryCard(controller.totalUsed, Colors.red.shade100),

                const SizedBox(height: 12),

                // ===================== REMAINING =====================
                _sectionHeader("Remaining Stock"),
                _remainingStockCard(controller.totalRemaining),
              ],
            ),
          );
        },
      ),
    );
  }

  // -------------------------------------------------------------
  // Section Title (looks like "Week X" in FilterUsageListView)
  // -------------------------------------------------------------
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(
        title,
        style: AppTextStyles.bold(fontSize: 20, fontColor: AppColors.blueColor),
      ),
    );
  }

  // -------------------------------------------------------------
  // Summary Card (Total Added / Total Used)
  // -------------------------------------------------------------
  Widget _summaryCard(Map<String, int> data, Color bgColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children:
              data.entries.map((e) {
                return _summaryRow(e.key, e.value);
              }).toList(),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: AppTextStyles.bold(
              fontSize: 16,
              fontColor: AppColors.blackColor30,
            ),
          ),
          Text(
            value.toString(),
            style: AppTextStyles.bold(
              fontSize: 16,
              fontColor: AppColors.UPMaroonColor,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // Remaining Stock (Color-coded like usage rows)
  // -------------------------------------------------------------
  Widget _remainingStockCard(Map<String, int> data) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children:
              data.entries.map((e) {
                return _remainingRow(e.key, e.value);
              }).toList(),
        ),
      ),
    );
  }

  Widget _remainingRow(String label, int value) {
    Color color;
    if (value <= 5) {
      color = Colors.red;
    } else if (value <= 20) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: AppTextStyles.bold(
              fontSize: 16,
              fontColor: AppColors.blackColor,
            ),
          ),
          Text(
            value.toString(),
            style: AppTextStyles.bold(fontSize: 16, fontColor: color),
          ),
        ],
      ),
    );
  }
}
