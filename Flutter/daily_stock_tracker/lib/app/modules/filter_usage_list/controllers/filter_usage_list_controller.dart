import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterUsageListController extends GetxController {
  // final selectedMonthFilter = "".obs;
  // final selectedYearFilter = "".obs;

  final fromDate = "".obs;
  final toDate = "".obs;

  var usageList = <StockUsageModel>[].obs;
  var weeklyGroups = <dynamic>[].obs;

  final db = DBService();

  @override
  void onInit() {
    super.onInit();

    final now = DateTime.now();

    // NEW DEFAULT RANGE --------------------
    final from = now.subtract(Duration(days: 15)); // 15 days ago
    fromDate.value = _format(from);

    toDate.value = _format(now); // Today
    // --------------------------------------

    getFilteredDataByWeek();
  }

  String _format(DateTime dt) => dt.toIso8601String().split("T").first;

  Future<void> pickFromDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.parse(fromDate.value),
      firstDate: DateTime(2020),
      lastDate: DateTime.parse(toDate.value), // ⛔ cannot go beyond TO date
    );

    if (picked != null) {
      final newDate = _format(picked);

      // IF fromDate > toDate → prevent
      if (picked.isAfter(DateTime.parse(toDate.value))) {
        Get.snackbar(
          "Invalid Date",
          "From date cannot be greater than To date.",
        );
        return;
      }

      fromDate.value = newDate;
      getFilteredDataByWeek();
    }
  }

  Future<void> pickToDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.parse(toDate.value),
      firstDate: DateTime.parse(
        fromDate.value,
      ), // ⛔ cannot be less than FROM date
      lastDate: DateTime.now(), // ⛔ cannot go beyond today
    );

    if (picked != null) {
      final newDate = _format(picked);

      // IF toDate < fromDate → prevent
      if (picked.isBefore(DateTime.parse(fromDate.value))) {
        Get.snackbar(
          "Invalid Date",
          "To date cannot be earlier than From date.",
        );
        return;
      }

      toDate.value = newDate;
      getFilteredDataByWeek();
    }
  }

  /// =========================================
  /// FETCH FILTERED DATA FROM SQLITE
  /// FETCH DATA BETWEEN DATES
  /// =========================================

  Future<void> getFilteredDataByWeek() async {
    final data = await db.getUsageBetweenDates(fromDate.value, toDate.value);
    usageList.value = data;

    groupByWeeks();
  }

  /*void groupByWeeks() {
    final temp = <String, List<StockUsageModel>>{};

    for (final item in usageList) {
      final date = DateTime.parse(item.createdAt ?? '0');
      final weekNo = ((date.day - 1) / 7).floor() + 1;
      final key = "Week $weekNo";

      temp.putIfAbsent(key, () => []);
      temp[key]!.add(item);
    }

    weeklyGroups.clear();

    temp.forEach((week, items) {
      weeklyGroups.add({
        "weekLabel": week,
        "total": _calculateTotals(items),
        // "items": items,
        "items": items.reversed.toList(),
      });
    });
  }*/

  /*void groupByWeeks() {
    final temp = <String, List<StockUsageModel>>{};

    // GROUP ITEMS BY WEEK
    for (final item in usageList) {
      final date = DateTime.parse(item.createdAt ?? '0');
      final weekNo = ((date.day - 1) / 7).floor() + 1;
      final key = "Week $weekNo";

      temp.putIfAbsent(key, () => []);
      temp[key]!.add(item);
    }

    // SORT WEEK KEYS IN DESC ORDER
    final sortedKeys = temp.keys.toList()
      ..sort((a, b) {
        int wkA = int.parse(a.split(" ").last);
        int wkB = int.parse(b.split(" ").last);
        return wkB.compareTo(wkA); // DESC
      });

    weeklyGroups.clear();

    // ADD GROUPS IN ORDER + SORT ITEMS IN EACH GROUP
    for (final week in sortedKeys) {
      final items = temp[week]!;

      // SORT DATE IN DESC ORDER INSIDE WEEK
      items.sort((a, b) => DateTime.parse(b.createdAt!)
          .compareTo(DateTime.parse(a.createdAt!)));

      weeklyGroups.add({
        "weekLabel": week,
        "total": _calculateTotals(items),
        "items": items,
      });
    }
  }*/

  void groupByWeeks() {
    final temp = <String, Map<String, List<StockUsageModel>>>{};
    // Structure:
    // {
    //   "2024-12": {
    //       "Week 1": [items],
    //       "Week 2": [items]
    //   },
    //   "2024-11": { ... }
    // }

    for (final item in usageList) {
      final date = DateTime.parse(item.createdAt!);

      final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
      final weekNo = ((date.day - 1) / 7).floor() + 1;
      final weekKey = "Week $weekNo";

      temp.putIfAbsent(monthKey, () => {});
      temp[monthKey]!.putIfAbsent(weekKey, () => []);
      temp[monthKey]![weekKey]!.add(item);
    }

    weeklyGroups.clear();

    // SORT MONTHS DESC
    final sortedMonths = temp.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    for (final month in sortedMonths) {
      final weeksMap = temp[month]!;

      // SORT WEEKS DESC
      final sortedWeeks = weeksMap.keys.toList()
        ..sort((a, b) {
          int wkA = int.parse(a.split(" ").last);
          int wkB = int.parse(b.split(" ").last);
          return wkB.compareTo(wkA);
        });

      for (final week in sortedWeeks) {
        final items = weeksMap[week]!;

        // SORT DATES DESC
        items.sort((a, b) =>
            DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));

        weeklyGroups.add({
          "month": month,          // Example: "2024-12"
          "weekLabel": week,       // Week 1, Week 2
          "total": _calculateTotals(items),
          "items": items,
        });
      }
    }
  }


  Map<String, int> _calculateTotals(List<StockUsageModel> items) {
    return {
      "Idli": items.fold(0, (sum, i) => sum + int.parse(i.idli ?? '0')),
      "Chatani": items.fold(0, (sum, i) => sum + int.parse(i.chatani ?? '0')),
      "MW": items.fold(0, (sum, i) => sum + int.parse(i.meduWada ?? '0')),
      "Appe": items.fold(0, (sum, i) => sum + int.parse(i.appe ?? '0')),
      "S Full": items.fold(
        0,
        (sum, i) => sum + int.parse(i.sambhar_full ?? '0'),
      ),
      "S Half": items.fold(
        0,
        (sum, i) => sum + int.parse(i.sambhar_half ?? '0'),
      ),
      "S 1/4": items.fold(
        0,
        (sum, i) => sum + int.parse(i.sambhar_one_fourth ?? '0'),
      ),
      "20 ltr": items.fold(
        0,
        (sum, i) => sum + int.parse(i.water_bottle_20l ?? '0'),
      ),
    };
  }

  Future<void> deleteRecord(int id) async {
    await db.deleteUsage(id);
    getFilteredDataByWeek(); // refresh list
    Get.snackbar("Deleted", "Record deleted successfully");
  }

  /*String formatDate(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    return DateFormat("EEE, dd-MMM-yyyy").format(dt);
  }*/
  String formatDate(String date) =>
      DateFormat("EEE, dd-MMM-yyyy").format(DateTime.parse(date));

  int getWeekNumber(String date) {
    final dt = DateTime.parse(date);
    return ((dt.day - 1) / 7).floor() + 1;
  }

  Color getWeekdayColor(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    String day = DateFormat('EEE').format(dt); // Mon, Tue, ...

    switch (day) {
      case "Mon":
        return Colors.blue;
      case "Tue":
        return Colors.green;
      case "Wed":
        return Colors.orange;
      case "Thu":
        return Colors.purple;
      case "Fri":
        return Colors.teal;
      case "Sat":
        return Colors.red;
      case "Sun":
        return Colors.brown;
      default:
        return Colors.black;
    }
  }

  Future<void> showImportExportDialog() async {
    Get.defaultDialog(
      title: "Select Action",
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await exportDbFile();
            },
            child: Text("Export Database"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await importDbFile();
            },
            child: Text("Import Database"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // close dialog
              Get.defaultDialog(
                title: "Confirm?",
                middleText: "Are you sure you want to delete ALL data?",
                textCancel: "No",
                textConfirm: "Yes",
                confirmTextColor: Colors.white,
                onConfirm: () async {
                  Get.back(); // close dialog
                  await clearAllStockData();
                },
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text(
              "Clear All Data",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> exportDbFile() async {
    try {
      String path = await db.exportDatabase();
      Get.snackbar("Success", "Database exported:\n$path");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> importDbFile() async {
    try {
      await db.importDatabase();
      Get.snackbar("Imported", "Database imported successfully!");
      await getFilteredDataByWeek(); // refresh data
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> clearAllStockData() async {
    try {
      await db.clearAllData();
      await getFilteredDataByWeek(); // refresh UI
      Get.snackbar("Cleared", "All data has been deleted!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
