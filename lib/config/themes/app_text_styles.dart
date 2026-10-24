import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';

/// Type scale measured from the Figma screens (390 × 844 frames). Sizes go
/// through ScreenUtil, so read these only below `ScreenUtilInit`.
///
/// Every style names its font: some widgets (buttons, for one) don't inherit
/// the theme's font family. Single lines keep the font's natural line height,
/// as Figma's "auto" does; paragraphs use the design's explicit spacing.
abstract final class AppTextStyles {
  static TextTheme get textTheme => TextTheme(
    titleMedium: _readex(14, weight: FontWeight.w600),
    bodyLarge: _readex(16),
    bodyMedium: _readex(14),
    bodySmall: _readex(12),
    labelLarge: _readex(15, weight: FontWeight.w600),
  );

  /// Splash wordmark "إجابة".
  static TextStyle get wordmark => _amiri(44);

  /// Screen titles ("أين أنتِ؟", "حتى يصلك التنبيه").
  static TextStyle get screenTitle => _amiri(28, color: AppColors.ink);

  /// The welcome headline.
  static TextStyle get heroTitle => _amiri(29, color: AppColors.ink);

  /// [screenTitle] in Arabic. Latin titles use Readex Pro: the handover
  /// keeps Amiri for dua text and Arabic titles.
  static TextStyle screenTitleFor(Locale locale) => locale.languageCode == 'ar'
      ? screenTitle
      : _readex(23, weight: FontWeight.w600, color: AppColors.ink);

  /// [heroTitle] in Arabic, Readex Pro otherwise (see [screenTitleFor]).
  static TextStyle heroTitleFor(Locale locale) => locale.languageCode == 'ar'
      ? heroTitle
      : _readex(24, weight: FontWeight.w600, color: AppColors.ink);

  /// One line under a screen title.
  static TextStyle get subtitle => _readex(12.5, color: AppColors.muted);

  /// The welcome paragraph.
  static TextStyle get lead =>
      _readex(13.5, height: 1.9, color: AppColors.muted);

  /// Paragraphs under a title.
  static TextStyle get body =>
      _readex(12.5, height: 1.76, color: AppColors.muted);

  /// Option and step titles.
  static TextStyle get cardTitle =>
      _readex(14, weight: FontWeight.w600, color: AppColors.ink);

  /// Option and step descriptions.
  static TextStyle get cardSubtitle =>
      _readex(10.5, height: 1.62, color: AppColors.muted);

  /// Small headings above a section.
  static TextStyle get sectionLabel =>
      _readex(11, weight: FontWeight.w500, color: AppColors.muted);

  /// Primary button label.
  static TextStyle get button => _readex(15, weight: FontWeight.w600);

  /// Footnotes under buttons and sections.
  static TextStyle get caption => _readex(9.5, color: AppColors.faint);

  /// Dua and Quranic text.
  static TextStyle get dua =>
      _amiri(23, weight: FontWeight.w400, color: AppColors.ink);

  /// A dua's meaning or transliteration under the Arabic.
  static TextStyle get duaMeaning => _readex(11.5, color: AppColors.inkSoft);

  static TextStyle _readex(
    double size, {
    FontWeight weight = FontWeight.w400,
    double? height,
    Color? color,
  }) => TextStyle(
    fontFamily: AppFonts.readexPro,
    fontSize: size.sp,
    fontWeight: weight,
    height: height,
    color: color,
  );

  static TextStyle _amiri(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
  }) => TextStyle(
    fontFamily: AppFonts.amiri,
    fontSize: size.sp,
    fontWeight: weight,
    color: color,
  );
}
