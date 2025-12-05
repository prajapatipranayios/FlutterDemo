import 'package:daily_stock_tracker/app/modules/stock_display/controllers/stock_display_controller.dart';
import 'package:daily_stock_tracker/app/routes/app_pages.dart';
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
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(Icons.list, color: AppColors.blackColor, size: 30),
            onPressed: () async {
              // Get.toNamed(Routes.ADD_STOCK);
              Get.toNamed(Routes.STOCK_ENTRY_LIST)?.then((value) {
                controller.loadStockSummary();
              });
            },
          ),
        ],
      ),

      body: GetBuilder<StockDisplayController>(
        builder: (_) {
          if (controller.totalAdded.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              children: [
                // ===================== REMAINING =====================
                _sectionHeader("Remaining Stock"),
                _remainingStockCard(controller.totalRemaining),
                const SizedBox(height: 8),

                // ===================== TOTAL USED =====================
                _sectionHeader("Total Used"),
                _summaryCard(
                  controller.totalUsed,
                  Colors.red.shade100,
                  Colors.red.shade50,
                ),
                const SizedBox(height: 8),

                // ===================== TOTAL ADDED =====================
                _sectionHeader("Total Stock Added"),
                _summaryCard(
                  controller.totalAdded,
                  Colors.blue.shade100,
                  Colors.blue.shade50,
                ),
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
  Widget _summaryCard(Map<String, int> data, Color bgColor, Color bgTileColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 45,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final entry = data.entries.elementAt(index);
          return _summaryTile(entry.key, entry.value, bgTileColor);
        },
      ),
    );
  }

  // Widget _summaryCard(Map<String, int> data, Color bgColor) {
  //   return Wrap(
  //     spacing: 10,
  //     runSpacing: 10,
  //     children:
  //         data.entries.map((e) {
  //           return Chip(
  //             padding: const EdgeInsets.all(6),
  //             label: Text(
  //               "${e.key}: ${e.value}",
  //               style: AppTextStyles.bold(
  //                 fontSize: 14,
  //                 fontColor: Colors.black,
  //               ),
  //             ),
  //             backgroundColor: bgColor,
  //           );
  //         }).toList(),
  //   );
  // }

  Widget _summaryTile(String label, int value, Color bgColor) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.only(left: 8, right: 4, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(blurRadius: 2, spreadRadius: 0.5, color: Colors.black12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ${value.toString()}',
            style: AppTextStyles.bold(
              fontSize: 15,
              fontColor: AppColors.blackColor30,
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
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 4, spreadRadius: 1, color: Colors.black12),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 45,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final entry = data.entries.elementAt(index);
          return _remainingTile(entry.key, entry.value);
        },
      ),
    );
  }

  Widget _remainingTile(String label, int value) {
    Color color = Colors.green;

    // Custom rules per item
    switch (label) {
      case "Idli":
      case "Chatani":
        if (value <= 40) {
          color = Colors.red;
        } else if (value <= 60) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "MeduWada":
      case "Appe":
        if (value <= 20) {
          color = Colors.red;
        } else if (value <= 30) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "S Full":
        if (value <= 25) {
          color = Colors.red;
        } else if (value <= 45) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "S Half":
        if (value <= 25) {
          color = Colors.red;
        } else if (value <= 45) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "S 1/4":
        if (value <= 25) {
          color = Colors.red;
        } else if (value <= 45) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "1 Ltr":
        if (value <= 100) {
          color = Colors.red;
        } else if (value <= 150) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      case "500 ml":
        if (value <= 150) {
          color = Colors.red;
        } else if (value <= 200) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
        break;

      default:
        // For all other items → standard rule
        if (value <= 5) {
          color = Colors.red;
        } else if (value <= 20) {
          color = Colors.orange;
        } else {
          color = Colors.green;
        }
    }

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 4, top: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ${value.toString()}",
            style: AppTextStyles.bold(
              fontSize: 15,
              fontColor: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
