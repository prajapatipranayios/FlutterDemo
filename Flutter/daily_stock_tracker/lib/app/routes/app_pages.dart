import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/filter_usage_list/bindings/filter_usage_list_binding.dart';
import '../modules/filter_usage_list/views/filter_usage_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = Routes.DASHBOARD;

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
  ];
}
