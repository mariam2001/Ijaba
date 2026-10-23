import 'package:flutter/material.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(
    const ColorScheme.light().copyWith(
      primary: AppColors.green,
      onPrimary: AppColors.paper,
      primaryContainer: AppColors.greenPale,
      onPrimaryContainer: AppColors.greenDeep,
      secondary: AppColors.greenMid,
      onSecondary: AppColors.paper,
      secondaryContainer: AppColors.greenPale,
      onSecondaryContainer: AppColors.greenDeep,
      tertiary: AppColors.honey,
      onTertiary: AppColors.greenDeep,
      surface: AppColors.paper,
      onSurface: AppColors.ink,
    ),
  );

  /// Provisional: maps existing tokens onto a dark scheme until the night
  /// palette (nightCard, nightInk, nightMuted, nightLine) is available.
  static ThemeData get night => _build(
    const ColorScheme.dark().copyWith(
      primary: AppColors.greenMid,
      onPrimary: AppColors.paper,
      secondary: AppColors.greenPale,
      onSecondary: AppColors.greenDeep,
      tertiary: AppColors.honey,
      onTertiary: AppColors.greenDeep,
      surface: AppColors.night,
      onSurface: AppColors.paper,
    ),
  );

  static ThemeData _build(ColorScheme colorScheme) => ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    fontFamily: AppFonts.readexPro,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    ),
  );
}
