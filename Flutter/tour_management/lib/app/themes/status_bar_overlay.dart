import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class StatusBarOverlays {
  /// White icons & text (good for dark backgrounds)
  static const lightIcons = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Android: white icons
    statusBarBrightness: Brightness.dark,      // iOS: white icons
  );

  /// Dark icons & text (good for light backgrounds)
  static const darkIcons = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // Android: black icons
    statusBarBrightness: Brightness.light,    // iOS: black icons
  );
}
