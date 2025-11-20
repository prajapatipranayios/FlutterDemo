import 'package:daily_stock_tracker/app/routes/app_pages.dart';
import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_usage_list_controller.dart';

class FilterUsageListView extends GetView<FilterUsageListController> {
  const FilterUsageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usage List'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                /// ======= MONTH DROPDOWN SECTION =======
                Expanded(
                  child: Obx(() {
                    return Container(
                      height: 45.0,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedMonthFilter.value,
                          items: controller.filterMonths
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedMonthFilter.value = value!;
                          },
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16.0),

                /// ======= YEAR DROPDOWN SECTION =======
                Expanded(
                  child: Obx(() {
                    return Container(
                      height: 45.0,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedYearFilter.value,
                          items: controller.filterYears
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedYearFilter.value = value!;
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(height: 20),

            /// ==== LIST OF FILTERED RESULTS ====
            Expanded(
              child: Obx(() {
                if (controller.usageList.isEmpty) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.usageList.length,
                  itemBuilder: (context, index) {
                    final item = controller.usageList[index];

                    return Card(
                      child: ListTile(
                        onTap: () {
                          // 👇 SEND SELECTED ITEM BACK TO DASHBOARD PAGE
                          //Get.back(result: item);
                          Get.offNamed(Routes.DASHBOARD, arguments: item);
                        },
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Delete?"),
                              content: const Text(
                                "Do you want to delete this entry?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back(); // CLOSE POPUP
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.back(); // 🔥 CLOSE POPUP FIRST
                                    await Future.delayed(
                                      Duration(milliseconds: 100),
                                    );
                                    controller.deleteRecord(item.id!);
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        },
                        title: Text(
                          "Date: ${controller.formatDate(item.createdAt)}",
                          style: AppTextStyles.bold(
                            fontSize: 18,
                            fontColor: AppColors.blackColor,
                          ),
                        ),
                        subtitle: Text(
                          "Idli: ${item.idli} \nChatani: ${item.chatani} \nMeduWada: ${item.meduWada} \nAppe: ${item.appe}",
                          style: AppTextStyles.semiBold(
                            fontSize: 17,
                            fontColor: AppColors.darkBlack,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
