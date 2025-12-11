import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

class SnackbarHelper {
  // Private constructor
  SnackbarHelper._();

  static void show(
      BuildContext context,
      String message, {
        SnackbarType type = SnackbarType.info,
        String? actionLabel,
        VoidCallback? onAction,
        Duration duration = const Duration(seconds: 2),
        TextStyle? textStyle, // ← New optional parameter
      }) {
    // Set background color based on type
    Color backgroundColor;
    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red;
        break;
      case SnackbarType.warning:
        backgroundColor = Colors.orange;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = Colors.blue;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // content: Text(message, style: const TextStyle(color: Colors.white)),
        content: Text(
          message,
          style: textStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 17,       // default font size
                fontWeight: FontWeight.w500, // medium weight
              ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
          label: actionLabel,
          onPressed: onAction,
          textColor: Colors.white, // You can customize
        )
            : null,
      ),
    );
  }
}


/// Example
// SnackbarHelper.show(
// Get.context!,
// "Item deleted",
// type: SnackbarType.error,
// position: SnackbarPosition.middle,
// actionLabel: "Undo",
// onAction: () {
// print("Undo clicked");
// },
// );

