import 'dart:ui';

class AppColors {
  // static Color fromHex(String hexCode) {
  //   final hex = hexCode.replaceAll('#', '');
  //   return Color(int.parse('FF$hex', radix: 16)); // Always add full opacity
  // }

  static Color colorWithOpacity(String hexColor, [String? opacityPercent]) {
    // Remove '#' and convert to uppercase
    String hex = hexColor.replaceAll('#', '').toUpperCase();

    // If hex already has alpha (8 characters), just use it directly
    if (hex.length == 8) {
      return Color(int.parse('0x$hex'));
    }

    // Otherwise, add alpha from opacityPercent (default 100%)
    int opacity = int.tryParse(opacityPercent ?? '') ?? 100;
    opacity = opacity.clamp(0, 100);
    final alpha =
        ((opacity / 100) * 255)
            .round()
            .toRadixString(16)
            .padLeft(2, '0')
            .toUpperCase();

    return Color(int.parse('0x$alpha$hex'));
  }

  // static const colorWhite = Color(0x00FFFFFF);
  // static const colorBlack = Color(0x00000000);

  // static final colorClear = colorWithOpacity('000000', '50');
  static final colorClear = colorWithOpacity('00000000');
  static final colorWhite = colorWithOpacity('FFFFFFFF');
  static final colorBlack = colorWithOpacity('000000');
  static final colorDarkSlateGray = colorWithOpacity('2F4F4F');
  static final colorBlue = colorWithOpacity('0000FF');
  static final colorDeepSkyBlue = colorWithOpacity('00BFFF');
  static final colorGreen = colorWithOpacity('008000');
  static final colorForestGreen = colorWithOpacity('228B22');
  static final colorLightGreen = colorWithOpacity('90EE90');
  static final colorLimeGreen = colorWithOpacity('32CD32');
  static final colorMagenta = colorWithOpacity('FF00FF');
  static final colorPink = colorWithOpacity('FFC0CB');
  static final colorLightPink = colorWithOpacity('FFB6C1');
  static final colorSeparate = colorWithOpacity('353535');
  static final colorGray = colorWithOpacity('7b7b7b');
  static final colorLightGray = colorWithOpacity('f2f2f2');
  static final colorSuccessGreen = colorWithOpacity('30ae33');
  static final colorDisable = colorWithOpacity('dddddd');
  static final colorThemeRed = colorWithOpacity('8b0000');
}
