import 'package:flutter/material.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';

/// `context.colors` / `context.textStyles`: the current theme's palette and
/// type scale. Reading them makes the widget rebuild when the theme changes
/// (day ↔ night), as `Theme.of` does.
extension AppThemeContext on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.day;

  AppTextStyles get textStyles => AppTextStyles(colors);
}
