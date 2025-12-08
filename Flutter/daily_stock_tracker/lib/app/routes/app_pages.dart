import 'package:get/get.dart';

import '../modules/add_stock/bindings/add_stock_binding.dart';
import '../modules/add_stock/views/add_stock_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/filter_usage_list/bindings/filter_usage_list_binding.dart';
import '../modules/filter_usage_list/views/filter_usage_list_view.dart';
import '../modules/stock_display/bindings/stock_display_binding.dart';
import '../modules/stock_display/views/stock_display_view.dart';
import '../modules/stock_entry_list/bindings/stock_entry_list_binding.dart';
import '../modules/stock_entry_list/views/stock_entry_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static final INITIAL = Routes.DASHBOARD;
  static final INITIAL = Routes.FILTER_USAGE_LIST;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_USAGE_LIST,
      page: () => const FilterUsageListView(),
      binding: FilterUsageListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_STOCK,
      page: () => const AddStockView(),
      binding: AddStockBinding(),
    ),
    GetPage(
      name: _Paths.STOCK_DISPLAY,
      page: () => const StockDisplayView(),
      binding: StockDisplayBinding(),
    ),
    GetPage(
      name: _Paths.STOCK_ENTRY_LIST,
      page: () => const StockEntryListView(),
      binding: StockEntryListBinding(),
    ),
  ];
}
