import 'package:flutter/material.dart';

class AppPopup {
  static arenaInfoPopup({required BuildContext context, String? title}) {
    showDialog(
      context: context,
      barrierDismissible: true, // dismiss when tapping outside
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16), // 👈 16 padding all around
          backgroundColor: Colors.white,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Text(
                  title ?? 'Arena Info',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      "This is your custom full-screen popup content. Add anything here.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                // Close button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
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
