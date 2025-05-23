import 'dart:ui';

class AppColors {
  static Color fromHex(String hexCode) {
    final hex = hexCode.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16)); // Always add full opacity
  }

  // static const colorWhite = Color(0x00FFFFFF);
  // static const colorBlack = Color(0x00000000);

  static final colorWhite = fromHex('FFFFFF');
  static final colorBlack = fromHex('000000');
  static final colorDarkSlateGray = fromHex('2F4F4F');
  static final colorBlue = fromHex('0000FF');
  static final colorDeepSkyBlue = fromHex('00BFFF');
  static final colorGreen = fromHex('008000');
  static final colorForestGreen = fromHex('228B22');
  static final colorLightGreen = fromHex('90EE90');
  static final colorLimeGreen = fromHex('32CD32');
  static final colorMagenta = fromHex('FF00FF');
  static final colorPink = fromHex('FFC0CB');
  static final colorLightPink = fromHex('FFB6C1');
  static final colorSeparate = fromHex('353535');
  static final colorGray = fromHex('7b7b7b');
  static final colorLightGray = fromHex('f2f2f2');
  static final colorSuccessGreen = fromHex('30ae33');
  static final colorDisable = fromHex('dddddd');
  static final colorThemeRed = fromHex('8b0000');
}
