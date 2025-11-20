import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_color.dart';
import '../../themes/app_text_styles.dart';

enum AppButtonType { primary, secondary, outline }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.loading = false,
    this.expand = true,
    this.icon,
    this.margin,
    this.enabled = true,
    this.backgroundColor = AppColors.themeColor,
    this.foregroundColor = AppColors.whiteColor,
    this.textStyle,
  });

  /// If you store translation keys, pass them here and use `.tr` in build.
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool loading;
  final bool expand;
  final Widget? icon;
  final EdgeInsetsGeometry? margin;
  final bool enabled;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : _buildContent();

    final button = switch (type) {
      AppButtonType.primary => ElevatedButton(
        onPressed: _onTap,
        style:
            ElevatedButton.styleFrom(
              foregroundColor: foregroundColor,
              textStyle:
                  textStyle ??
                  AppTextStyles.semiBold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppColors.disableColor; // 👈 disabled color
                }
                return backgroundColor; // 👈 normal color
              }),
            ),
        child: child,
      ),
      AppButtonType.secondary => FilledButton.tonal(
        onPressed: _onTap,
        child: child,
      ),
      AppButtonType.outline => OutlinedButton(onPressed: _onTap, child: child),
    };

    final wrapped = expand
        ? SizedBox(width: double.infinity, height: 55, child: button)
        : button;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: wrapped,
    );
  }

  VoidCallback? get _onTap => (!enabled || loading) ? null : onPressed;

  Widget _buildContent() {
    if (icon == null) {
      return Text(label.tr); // use translations if provided
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon!, const SizedBox(width: 8), Text(label.tr)],
    );
  }
}
