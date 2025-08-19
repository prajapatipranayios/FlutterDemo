import 'package:flutter/material.dart';

enum TextSize { small, medium, large }

class AppTextStyles {
  static TextStyle themeRegularStyle({fontSize, fontColor}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontFamily: 'OpenSans-Regular', // Replace with your actual font family
      color: fontColor,
    );
  }

  static TextStyle themeMediumStyle({fontSize, fontColor}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: 'OpenSans-Semibold', // Replace with your actual font family
      color: fontColor,
    );
  }

  static TextStyle themeBoldStyle({fontSize, fontColor}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontFamily: 'OpenSans-Bold', // Replace with your actual font family
      color: fontColor,
    );
  }

  // static TextStyle getTitleStyle(
  //   BuildContext context, {
  //   TextSize size = TextSize.medium,
  //   FontWeight fontWeight = FontWeight.bold,
  //   FontStyle fontStyle = FontStyle.normal,
  //   String fontFamily = 'OpenSans-Bold',
  // }) {
  //   final brightness = Theme.of(context).brightness;
  //   final isDark = brightness == Brightness.dark;
  //
  //   double fontSize;
  //   switch (size) {
  //     case TextSize.small:
  //       fontSize = 16;
  //       break;
  //     case TextSize.medium:
  //       fontSize = 20;
  //       break;
  //     case TextSize.large:
  //       fontSize = 25;
  //       break;
  //   }
  //
  //   return TextStyle(
  //     fontSize: fontSize,
  //     fontWeight: fontWeight,
  //     fontStyle: fontStyle,
  //     fontFamily: fontFamily,
  //     color: isDark ? Colors.white : Colors.black,
  //   );
  // }
}
