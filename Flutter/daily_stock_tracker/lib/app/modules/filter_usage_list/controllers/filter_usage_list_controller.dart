import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:daily_stock_tracker/app/core/services/db_service.dart';
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
    getFilteredData();
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
  Future<void> getFilteredData() async {
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
    return DateFormat("dd-MMM-yyyy").format(dt);
  }

  Future<void> deleteRecord(int id) async {
    await db.deleteUsageById(id);
    getFilteredData(); // refresh list
    Get.snackbar("Deleted", "Record deleted successfully");
  }
}
