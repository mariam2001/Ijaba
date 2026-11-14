import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';

/// The day and night themes, each carrying its palette ([AppColors]) as a
/// theme extension.
abstract final class AppTheme {
  static ThemeData get light => _build(AppColors.day, Brightness.light);

  static ThemeData get night => _build(AppColors.night, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final styles = AppTextStyles(colors);
    // From Material's light/dark defaults, as before, so what the design
    // doesn't cover (snack bars, errors) keeps Material's colours.
    final base = brightness == Brightness.light
        ? const ColorScheme.light()
        : const ColorScheme.dark();
    final scheme = base.copyWith(
      primary: colors.green,
      onPrimary: colors.onGreen,
      primaryContainer: colors.greenPale,
      onPrimaryContainer: colors.greenDeep,
      secondary: colors.greenMid,
      onSecondary: colors.onGreen,
      secondaryContainer: colors.greenPale,
      onSecondaryContainer: colors.greenDeep,
      tertiary: colors.honey,
      onTertiary: AppColors.day.greenDeep,
      surface: colors.paper,
      onSurface: colors.ink,
      onSurfaceVariant: colors.muted,
      outline: colors.line,
      outlineVariant: colors.line,
    );
    return ThemeData(
      colorScheme: scheme,
      extensions: [colors],
      scaffoldBackgroundColor: colors.paper,
      fontFamily: AppFonts.readexPro,
      textTheme: styles.textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        systemOverlayStyle: brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        backgroundColor: colors.paper,
        foregroundColor: colors.ink,
      ),
      // The design's primary button: full width, 50 tall, radius 15.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          textStyle: styles.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.faint,
          textStyle: styles.caption,
        ),
      ),
    );
  }
}
