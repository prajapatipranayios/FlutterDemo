import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterUsageListController extends GetxController {
  var selectedMonthFilter = "".obs;
  var selectedYearFilter = "".obs;

  List<String> filterMonths = [
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
  List<String> filterYears = [];
  var usageList = <StockUsageModel>[].obs;
  var weeklyGroups = [].obs; // List of maps

  final db = DBService();

  @override
  void onInit() {
    super.onInit();

    /// ========== Set Current Month ==========
    int monthIndex = DateTime.now().month - 1;
    selectedMonthFilter.value = filterMonths[monthIndex];

    /// ========== Set Current Year ==========
    int currentYear = DateTime.now().year;
    selectedYearFilter.value = currentYear.toString();

    /// Populate last 5 years for dropdown
    filterYears = List.generate(5, (index) => (currentYear - index).toString());

    /// Load data for current month/year
    // getFilteredDataSimple();
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

  String formatDate(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    return DateFormat("EEE, dd-MMM-yyyy").format(dt);
  }

  Future<void> deleteRecord(int id) async {
    await db.deleteUsageById(id);
    getFilteredDataByWeek(); // refresh list
    Get.snackbar("Deleted", "Record deleted successfully");
  }

  Future<void> getFilteredDataByWeek() async {
    String month = selectedMonthFilter.value;
    String year = selectedYearFilter.value;

    int monthNumber = filterMonths.indexOf(month) + 1;
    String formattedMonth = monthNumber.toString().padLeft(2, '0');
    String queryLike = "$year-$formattedMonth";

    List<StockUsageModel> data = await db.getUsageByMonthYear(queryLike);

    usageList.value = data;

    groupByWeeks();
  }

  void groupByWeeks() {
    Map<String, List<StockUsageModel>> temp = {};

    for (var item in usageList) {
      DateTime date = DateTime.parse(item.createdAt);

      int weekOfMonth = ((date.day - 1) / 7).floor() + 1;
      String key = "Week $weekOfMonth";

      temp.putIfAbsent(key, () => []);
      temp[key]!.add(item);
    }

    // Convert into list format
    weeklyGroups.clear();

    temp.forEach((week, items) {
      // Calculate totals
      int totalIdli = items.fold(0, (sum, item) => sum + int.parse(item.idli));
      int totalChatani = items.fold(
        0,
        (sum, item) => sum + int.parse(item.chatani),
      );
      int totalMW = items.fold(
        0,
        (sum, item) => sum + int.parse(item.meduWada),
      );
      int totalAppe = items.fold(0, (sum, item) => sum + int.parse(item.appe));
      int totalSFull = items.fold(
        0,
        (sum, item) => sum + int.parse(item.sambhar_full),
      );
      int totalSHalf = items.fold(
        0,
        (sum, item) => sum + int.parse(item.sambhar_half),
      );
      int totalSQuarter = items.fold(
        0,
        (sum, item) => sum + int.parse(item.sambhar_one_fourth),
      );

      weeklyGroups.add({
        "weekLabel": week,
        "total": {
          "Idli": totalIdli,
          "Chatani": totalChatani,
          "MW": totalMW,
          "Appe": totalAppe,
          "S Full": totalSFull,
          "S Half": totalSHalf,
          "S 1/4": totalSQuarter,
        },
        "items": items,
      });
    });
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

  int getWeekNumber(String dateString) {
    DateTime dt = DateTime.parse(dateString);
    int weekNo = ((dt.day - 1) / 7).floor() + 1;
    return weekNo;
  }
}
