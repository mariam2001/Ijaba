import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_fonts.dart';

/// Type scale, sized with ScreenUtil — read only below `ScreenUtilInit`.
/// Colors come from the active theme. Sizes are provisional until the
/// design's type specs are available.
abstract final class AppTextStyles {
  /// UI text (Readex Pro, set as the theme's font family).
  static TextTheme get textTheme => TextTheme(
    headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.sp),
    bodyMedium: TextStyle(fontSize: 14.sp),
    bodySmall: TextStyle(fontSize: 12.sp),
    labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
  );

  /// Dua and Quranic text. The tall line height keeps diacritics clear.
  static TextStyle get dua =>
      TextStyle(fontFamily: AppFonts.amiri, fontSize: 24.sp, height: 2);

  /// Big Arabic titles, e.g. the splash wordmark.
  static TextStyle get arabicTitle => TextStyle(
    fontFamily: AppFonts.amiri,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
}
