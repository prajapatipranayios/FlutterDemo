import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterUsageListController extends GetxController {
  final selectedMonthFilter = "".obs;
  final selectedYearFilter = "".obs;

  final filterMonths = const [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  var filterYears = <String>[];

  var usageList = <StockUsageModel>[].obs;
  var weeklyGroups = <dynamic>[].obs;

  final db = DBService();

  // List<String> filterYears = [];
  // var usageList = <StockUsageModel>[].obs;
  // var weeklyGroups = [].obs; // List of maps
  // final db = DBService();

  @override
  void onInit() {
    super.onInit();

    // /// ========== Set Current Month ==========
    // int monthIndex = DateTime.now().month - 1;
    // selectedMonthFilter.value = filterMonths[monthIndex];
    //
    // /// ========== Set Current Year ==========
    // int currentYear = DateTime.now().year;
    // selectedYearFilter.value = currentYear.toString();
    //
    // /// Populate last 5 years for dropdown
    // filterYears = List.generate(5, (index) => (currentYear - index).toString());
    //
    // /// Load data for current month/year
    // // getFilteredDataSimple();
    // getFilteredDataByWeek();

    final now = DateTime.now();
    selectedMonthFilter.value = filterMonths[now.month - 1];
    selectedYearFilter.value = now.year.toString();

    filterYears.addAll(List.generate(5, (i) => (now.year - i).toString()));

    getFilteredDataByWeek();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// =========================================
  /// FETCH FILTERED DATA FROM SQLITE
  /// =========================================
  Future<void> getFilteredDataSimple() async {
    String month = selectedMonthFilter.value;
    String year = selectedYearFilter.value;

    /// Convert short month → number
    int monthNumber = filterMonths.indexOf(month) + 1;
    String formattedMonth = monthNumber.toString().padLeft(2, '0');

    /// Query format example: "2025-03%"
    String queryLike = "$year-$formattedMonth";

    usageList.value = await db.getUsageByMonthYear(queryLike);
  }

  String _monthToNumber(String month) {
    return (filterMonths.indexOf(month) + 1).toString().padLeft(2, '0');
  }

  Future<void> getFilteredDataByWeek() async {
    final monthNum = _monthToNumber(selectedMonthFilter.value);
    final queryLike = "${selectedYearFilter.value}-$monthNum";

    final data = await db.getUsageByMonthYear(queryLike);
    usageList.value = data;

    groupByWeeks();
  }

  void groupByWeeks() {
    final temp = <String, List<StockUsageModel>>{};

    for (final item in usageList) {
      final date = DateTime.parse(item.createdAt);
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
        "items": items,
      });
    });
  }

  Map<String, int> _calculateTotals(List<StockUsageModel> items) {
    return {
      "Idli": items.fold(0, (sum, i) => sum + int.parse(i.idli)),
      "Chatani": items.fold(0, (sum, i) => sum + int.parse(i.chatani)),
      "MW": items.fold(0, (sum, i) => sum + int.parse(i.meduWada)),
      "Appe": items.fold(0, (sum, i) => sum + int.parse(i.appe)),
      "S Full": items.fold(0, (sum, i) => sum + int.parse(i.sambhar_full)),
      "S Half": items.fold(0, (sum, i) => sum + int.parse(i.sambhar_half)),
      "S 1/4": items.fold(0, (sum, i) => sum + int.parse(i.sambhar_one_fourth)),
      "1 ltr": items.fold(0, (sum, i) => sum + int.parse(i.water_bottle_1l)),
      "500 ml": items.fold(0, (sum, i) => sum + int.parse(i.water_bottle_halfl)),
    };
  }

  Future<void> deleteRecord(int id) async {
    await db.deleteUsageById(id);
    getFilteredDataByWeek(); // refresh list
    Get.snackbar("Deleted", "Record deleted successfully");
  }

  /*String formatDate(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    return DateFormat("EEE, dd-MMM-yyyy").format(dt);
  }*/
  String formatDate(String date) =>
      DateFormat("EEE, dd-MMM-yyyy").format(DateTime.parse(date));

  /*int getWeekNumber(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    int weekNo = ((dt.day - 1) / 7).floor() + 1;
    return weekNo;
  }*/

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
