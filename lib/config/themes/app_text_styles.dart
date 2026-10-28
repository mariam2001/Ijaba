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

  /// Home header wordmark: Amiri in Arabic, Readex Pro for "Ijaba".
  static TextStyle homeWordmarkFor(Locale locale) => locale.languageCode == 'ar'
      ? _amiri(24, color: AppColors.green)
      : _readex(21, weight: FontWeight.w600, color: AppColors.green);

  /// "مفتوحة الآن" on the hero card.
  static TextStyle get heroBadge =>
      _readex(11, weight: FontWeight.w500, color: AppColors.honeyPale);

  /// The featured window's name on the hero card.
  static TextStyle heroWindowTitleFor(Locale locale) =>
      locale.languageCode == 'ar'
      ? _amiri(30, color: AppColors.paperSoft)
      : _readex(26, height: 1.35, color: AppColors.paperSoft);

  /// Secondary text on the green hero card.
  static TextStyle get heroCaption => _readex(12, color: AppColors.greenPale);

  /// The big "1:18" on the hero card.
  static TextStyle get countdown =>
      _readex(36, weight: FontWeight.w300, color: AppColors.paperSoft);

  /// Section headings on Home ("نوافذ اليوم").
  static TextStyle get sectionTitle =>
      _readex(13, weight: FontWeight.w600, color: AppColors.ink);

  /// Window names in lists.
  static TextStyle get rowTitle => _readex(14, color: AppColors.ink);

  /// Times at the end of list rows.
  static TextStyle get rowTime =>
      _readex(13, weight: FontWeight.w500, color: AppColors.ink);

  /// Bottom tab-bar labels.
  static TextStyle get tabLabel => _readex(9.5);

  /// Text on a summary chip ("4 of 6 alerts on").
  static TextStyle get chipLabel => _readex(12, color: AppColors.inkSoft);

  /// The figure at the end of a summary chip ("4 / 6").
  static TextStyle get chipValue =>
      _readex(11.5, weight: FontWeight.w600, color: AppColors.green);

  /// A light note at the foot of a screen.
  static TextStyle get footnote => _readex(
    11,
    weight: FontWeight.w300,
    height: 1.75,
    color: AppColors.faint,
  );

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
