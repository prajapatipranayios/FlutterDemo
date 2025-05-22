import 'package:flutter/material.dart';

enum TextSize { small, medium, large }

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'OpenSans-Light', // Replace with your actual font family
    color: Colors.black,
    letterSpacing: 1.2,
    height: 1.3,
  );

  static const TextStyle theamRegularStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'OpenSans-Semibold', // Replace with your actual font family
    color: Colors.black,
    letterSpacing: 1.2,
    height: 1.3,
  );

  static const TextStyle theamMediumStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: 'OpenSans-Bold', // Replace with your actual font family
    color: Colors.black,
    letterSpacing: 1.2,
    height: 1.3,
  );

  static const TextStyle theamBoldStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'OpenSans-Bold', // Replace with your actual font family
    color: Colors.black,
    letterSpacing: 1.2,
    height: 1.3,
  );

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
