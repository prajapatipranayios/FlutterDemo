import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppPopup {
  static arenaInfoPopup({
    required BuildContext context,
    String? title,
    required List<String> arrInfoTitle,
    required List<List<String>> arrInfo,
    required List<List<String>> arrImg,
  }) {
    final PageController _pageController = PageController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.white,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dialog Title
                Text(
                  title ?? 'Arena Info',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Swipeable Pages
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: arrInfoTitle.length,
                    itemBuilder: (context, index) {
                      final sectionTitle = arrInfoTitle[index];
                      final descList = arrInfo[index];
                      final imageList = arrImg[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔴 Title OUTSIDE the scroll view
                          Text(
                            sectionTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ✅ Scrollable content
                          Expanded(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: descList.length,
                                itemBuilder: (context, subIndex) {
                                  final desc = descList[subIndex];
                                  final img =
                                      (subIndex < imageList.length)
                                          ? imageList[subIndex]
                                          : '';

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Description
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          desc,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),

                                      // Image if exists
                                      if (img.trim().isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 200,
                                            color: Colors.grey.shade200,
                                            alignment: Alignment.center,
                                            child: Text(
                                              img,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Pagination Dots
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: arrInfoTitle.length,
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                      dotColor: Colors.grey.shade300,
                      activeDotColor: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Full-width red Close Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
