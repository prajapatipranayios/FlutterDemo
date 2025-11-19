import 'package:daily_stock_tracker/app/themes/app_color.dart';
import 'package:daily_stock_tracker/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool enabled;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final Color backgroundColor;
  final double width;
  final double radius;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;

  CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLength,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.backgroundColor = AppColors.textFieldBg,
    this.width = double.infinity,
    this.radius = 40,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
  }) : textStyle =
           textStyle ??
           AppTextStyles.medium(
             fontSize: 16.0,
             fontColor: AppColors.whiteColor,
           ),
       hintTextStyle =
           hintTextStyle ??
           AppTextStyles.regular(
             fontSize: 16.0,
             fontColor: AppColors.textHintColor,
           );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(
      //   color: enabled ? backgroundColor : AppColors.textFieldBgDisable,
      //   border: Border.all(
      //     color: enabled ? AppColors.lightBlack : AppColors.borderColorDisable,
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.all(Radius.circular(radius)),
      // ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: AppColors.whiteColor,
        textAlign: textAlign,
        maxLength: maxLength,
        style: textStyle,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        onTap: onTap,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText.tr,
          hintStyle: hintTextStyle,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
