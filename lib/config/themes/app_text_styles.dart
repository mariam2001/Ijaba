import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';

/// Type scale measured from the Figma screens (390 × 844 frames), coloured
/// from a palette: widgets read `context.textStyles`, which follows the
/// theme. Sizes go through ScreenUtil, so read these only below
/// `ScreenUtilInit`.
///
/// Every style names its font: some widgets (buttons, for one) don't inherit
/// the theme's font family. Single lines keep the font's natural line height,
/// as Figma's "auto" does; paragraphs use the design's explicit spacing.
class AppTextStyles {
  const AppTextStyles(this._colors);

  final AppColors _colors;

  /// The hero card keeps its day colours in both themes (the handover).
  static const _hero = AppColors.day;

  TextTheme get textTheme => TextTheme(
    titleMedium: _readex(14, weight: FontWeight.w600),
    bodyLarge: _readex(16),
    bodyMedium: _readex(14),
    bodySmall: _readex(12),
    labelLarge: _readex(15, weight: FontWeight.w600),
  );

  /// Splash wordmark "إجابة".
  TextStyle get wordmark => _amiri(44);

  /// Screen titles ("أين أنتِ؟", "حتى يصلك التنبيه").
  TextStyle get screenTitle => _amiri(28, color: _colors.ink);

  /// The welcome headline.
  TextStyle get heroTitle => _amiri(29, color: _colors.ink);

  /// [screenTitle] in Arabic. Latin titles use Readex Pro: the handover
  /// keeps Amiri for dua text and Arabic titles.
  TextStyle screenTitleFor(Locale locale) => locale.languageCode == 'ar'
      ? screenTitle
      : _readex(23, weight: FontWeight.w600, color: _colors.ink);

  /// [heroTitle] in Arabic, Readex Pro otherwise (see [screenTitleFor]).
  TextStyle heroTitleFor(Locale locale) => locale.languageCode == 'ar'
      ? heroTitle
      : _readex(24, weight: FontWeight.w600, color: _colors.ink);

  /// Home header wordmark: Amiri in Arabic, Readex Pro for "Ijaba".
  TextStyle homeWordmarkFor(Locale locale) => locale.languageCode == 'ar'
      ? _amiri(24, color: _colors.greenInk)
      : _readex(21, weight: FontWeight.w600, color: _colors.greenInk);

  /// "مفتوحة الآن" on the hero card.
  TextStyle get heroBadge =>
      _readex(11, weight: FontWeight.w500, color: _hero.honeyPale);

  /// The featured window's name on the hero card.
  TextStyle heroWindowTitleFor(Locale locale) => locale.languageCode == 'ar'
      ? _amiri(30, color: _hero.paperSoft)
      : _readex(26, height: 1.35, color: _hero.paperSoft);

  /// Secondary text on the green hero card.
  TextStyle get heroCaption => _readex(12, color: _hero.greenPale);

  /// The big "1:18" on the hero card.
  TextStyle get countdown =>
      _readex(36, weight: FontWeight.w300, color: _hero.paperSoft);

  /// Section headings on Home ("نوافذ اليوم").
  TextStyle get sectionTitle =>
      _readex(13, weight: FontWeight.w600, color: _colors.ink);

  /// Window names in lists.
  TextStyle get rowTitle => _readex(14, color: _colors.ink);

  /// Times at the end of list rows.
  TextStyle get rowTime =>
      _readex(13, weight: FontWeight.w500, color: _colors.ink);

  /// Bottom tab-bar labels.
  TextStyle get tabLabel => _readex(9.5);

  /// Text on a summary chip ("4 of 6 alerts on").
  TextStyle get chipLabel => _readex(12, color: _colors.inkSoft);

  /// The figure at the end of a summary chip ("4 / 6").
  TextStyle get chipValue =>
      _readex(11.5, weight: FontWeight.w600, color: _colors.greenInk);

  /// A light note at the foot of a screen.
  TextStyle get footnote => _readex(
    11,
    weight: FontWeight.w300,
    height: 1.75,
    color: _colors.faint,
  );

  /// One line under a screen title.
  TextStyle get subtitle => _readex(12.5, color: _colors.muted);

  /// The welcome paragraph.
  TextStyle get lead => _readex(13.5, height: 1.9, color: _colors.muted);

  /// Paragraphs under a title.
  TextStyle get body => _readex(12.5, height: 1.76, color: _colors.muted);

  /// Option and step titles.
  TextStyle get cardTitle =>
      _readex(14, weight: FontWeight.w600, color: _colors.ink);

  /// Option and step descriptions.
  TextStyle get cardSubtitle =>
      _readex(10.5, height: 1.62, color: _colors.muted);

  /// Small headings above a section.
  TextStyle get sectionLabel =>
      _readex(11, weight: FontWeight.w500, color: _colors.muted);

  /// Primary button label.
  TextStyle get button => _readex(15, weight: FontWeight.w600);

  /// Footnotes under buttons and sections.
  TextStyle get caption => _readex(9.5, color: _colors.faint);

  /// Dua and Quranic text.
  TextStyle get dua => _amiri(23, weight: FontWeight.w400, color: _colors.ink);

  /// A dua's meaning or transliteration under the Arabic.
  TextStyle get duaMeaning => _readex(11.5, color: _colors.inkSoft);

  /// The dua on the Dua screen. Tall lines leave room for the harakat.
  TextStyle get duaLarge =>
      _amiri(34, weight: FontWeight.w400, height: 2, color: _colors.ink);

  /// Simple Latin spelling under the dua (English mode).
  TextStyle get transliteration => _readex(12, color: _colors.muted);

  /// The meaning on the Dua screen.
  TextStyle get duaMeaningLarge =>
      _readex(13.5, height: 1.85, color: _colors.inkSoft);

  /// A dua's attribution, and its "verify before release" flag.
  TextStyle get duaSource => _readex(
    11,
    weight: FontWeight.w300,
    height: 1.65,
    color: _colors.muted,
  );

  /// Where the user is, atop the Dua screen ("Last third of the night"):
  /// honey by night, as in the night Dua design.
  TextStyle get contextTitle => _readex(
    11.5,
    weight: FontWeight.w600,
    color: _colors.isNight ? _colors.honey : _colors.green,
  );

  /// The line under [contextTitle] ("3:12 AM · 2 of 7").
  TextStyle get contextSubtitle => _readex(10, color: _colors.muted);

  /// The tasbih counter's figure.
  TextStyle get counter =>
      _readex(32, weight: FontWeight.w300, color: _colors.ink);

  /// Titles on Library cards ("أذكار الصباح").
  TextStyle get listCardTitle =>
      _readex(14, weight: FontWeight.w500, color: _colors.ink);

  /// The line under a Library card's title ("٢٣ ذكرًا").
  TextStyle get listCardCaption =>
      _readex(11, weight: FontWeight.w300, color: _colors.muted);

  /// A setting's current value ("الإسكندرية، مصر").
  TextStyle get settingsValue => _readex(11.5, color: _colors.muted);

  /// Text typed in a search field (its hint takes [AppColors.faint]).
  TextStyle get searchInput => _readex(13, color: _colors.ink);

  /// Labels of the paired Previous / Next buttons.
  TextStyle get pagerButton => _readex(12.5, weight: FontWeight.w600);

  static TextStyle _readex(
    double size, {
    FontWeight weight = FontWeight.w400,
    double? height,
    Color? color,
  }) => TextStyle(
    fontFamily: AppFonts.readexPro,
    // Readex Pro lacks some Arabic glyphs, like ﷺ; Amiri has them.
    fontFamilyFallback: const [AppFonts.amiri],
    fontSize: size.sp,
    fontWeight: weight,
    height: height,
    color: color,
  );

  static TextStyle _amiri(
    double size, {
    FontWeight weight = FontWeight.w700,
    double? height,
    Color? color,
  }) => TextStyle(
    fontFamily: AppFonts.amiri,
    fontSize: size.sp,
    fontWeight: weight,
    height: height,
    color: color,
  );
}
