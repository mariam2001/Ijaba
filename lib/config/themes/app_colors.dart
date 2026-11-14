import 'package:flutter/material.dart';

/// Brand tokens, as a day and a night palette (the handover's
/// `ijaba-assets/ASSETS.md` table). Widgets read the current one with
/// `context.colors` (see `app_theme_context.dart`), so they follow the theme;
/// [day] and [night] are for colours that must not change with it (the hero
/// card's text, a notification's accent).
///
/// It's a [ThemeExtension]: Flutter's way to carry custom tokens in
/// [ThemeData], so a theme change rebuilds whoever reads them — like
/// `Theme.of(context).colorScheme`, but with the design's own names.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.paper,
    required this.paperSoft,
    required this.paperWarm,
    required this.line,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.faint,
    required this.green,
    required this.greenDeep,
    required this.greenMid,
    required this.greenPale,
    required this.honey,
    required this.honeyPale,
  });

  static const day = AppColors(
    paper: Color(0xFFF6F2E7),
    paperSoft: Color(0xFFFFFDF6),
    paperWarm: Color(0xFFEDE7D6),
    line: Color(0xFFDDD6C4),
    ink: Color(0xFF22352C),
    inkSoft: Color(0xFF4A5F53),
    muted: Color(0xFF7A8C80),
    faint: Color(0xFFA4B3A8),
    green: Color(0xFF35634F),
    greenDeep: Color(0xFF1E3A2E),
    greenMid: Color(0xFF5C8A72),
    greenPale: Color(0xFFDCE7DF),
    honey: Color(0xFFC4873D),
    honeyPale: Color(0xFFF2E3CC),
  );

  static const night = AppColors(
    paper: Color(0xFF16221C),
    paperSoft: Color(0xFF1E2E26),
    paperWarm: Color(0xFF101A15),
    line: Color(0xFF2A3C33),
    ink: Color(0xFFEDE9DC),
    inkSoft: Color(0xFFC3CCC1),
    muted: Color(0xFF8FA396),
    faint: Color(0xFF62756A),
    // Darker than the day's, so paper text on it keeps 4.5:1 contrast.
    green: Color(0xFF3F7A5E),
    // Used for strong text, so it flips light.
    greenDeep: Color(0xFFDCE7DF),
    greenMid: Color(0xFF7DAF94),
    greenPale: Color(0xFF22372C),
    honey: Color(0xFFD59A55),
    honeyPale: Color(0xFF3A2D1C),
  );

  /// Main background.
  final Color paper;

  /// Raised surfaces (cards, selected options); text on green buttons.
  final Color paperSoft;

  /// Recessed rows, e.g. a switched-off alert.
  final Color paperWarm;

  /// Hairlines: card borders, inactive page dots.
  final Color line;

  /// Body text.
  final Color ink;

  /// Softer body text, e.g. a dua's meaning.
  final Color inkSoft;

  /// Secondary text: subtitles, labels, descriptions.
  final Color muted;

  /// Tertiary text and unselected radio rings.
  final Color faint;

  /// Primary: buttons, the hero card, app-icon background.
  final Color green;

  /// Strong text (light in the night palette).
  final Color greenDeep;

  /// Secondary.
  final Color greenMid;

  /// Soft fills, chips.
  final Color greenPale;

  /// Accent: the star, "open now" states.
  final Color honey;

  /// Honey-tinted fill, e.g. behind the current step's number.
  final Color honeyPale;

  /// Whether this is the night palette (or mostly it, mid-animation).
  bool get isNight => paper.computeLuminance() < 0.5;

  /// Green for text and icons, on the page or a [greenPale] tile: [green] by
  /// day; [greenMid] by night, where [green] is too faint (the handover does
  /// this for icons on night tiles). [green] stays for surfaces: buttons,
  /// switch tracks, the hero card.
  Color get greenInk => isNight ? greenMid : green;

  /// Text and icons on [green] (buttons): [paperSoft] by day; the day's
  /// paper by night, as the night palette's notes ask (4.5:1 on its green).
  Color get onGreen => isNight ? day.paper : paperSoft;

  @override
  AppColors copyWith() => this;

  /// Blends the palettes while the theme animates from one to the other.
  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      paper: mix(paper, other.paper),
      paperSoft: mix(paperSoft, other.paperSoft),
      paperWarm: mix(paperWarm, other.paperWarm),
      line: mix(line, other.line),
      ink: mix(ink, other.ink),
      inkSoft: mix(inkSoft, other.inkSoft),
      muted: mix(muted, other.muted),
      faint: mix(faint, other.faint),
      green: mix(green, other.green),
      greenDeep: mix(greenDeep, other.greenDeep),
      greenMid: mix(greenMid, other.greenMid),
      greenPale: mix(greenPale, other.greenPale),
      honey: mix(honey, other.honey),
      honeyPale: mix(honeyPale, other.honeyPale),
    );
  }
}
