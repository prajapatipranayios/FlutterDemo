import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle regular({
    required double fontSize,
    required Color fontColor,
    bool isUnderLine = false,
  }) {
    return TextStyle(
      color: fontColor,
      fontFamily: "NotoSans-Regular",
      fontSize: fontSize,
      decorationColor: fontColor,
      decoration: isUnderLine == true
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle medium({
    required double fontSize,
    required Color fontColor,
    bool isUnderLine = false,
  }) {
    return TextStyle(
      color: fontColor,
      fontFamily: "NotoSans-Medium",
      fontSize: fontSize,
      decorationColor: fontColor,
      decoration: isUnderLine == true
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle semiBold({
    required double fontSize,
    required Color fontColor,
    bool isUnderLine = false,
  }) {
    return TextStyle(
      color: fontColor,
      fontFamily: "NotoSans-SemiBold",
      fontSize: fontSize,
      decorationColor: fontColor,
      decoration: isUnderLine == true
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle bold({
    required double fontSize,
    required Color fontColor,
    bool isUnderLine = false,
  }) {
    return TextStyle(
      color: fontColor,
      fontFamily: "NotoSans-Bold",
      fontSize: fontSize,
      decorationColor: fontColor,
      decoration: isUnderLine == true
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle italic({
    required double fontSize,
    required Color fontColor,
    bool isUnderLine = false,
  }) {
    return TextStyle(
      color: fontColor,
      fontFamily: "NotoSans-Italic",
      fontSize: fontSize,
      decorationColor: fontColor,
      decoration: isUnderLine == true
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }
}
