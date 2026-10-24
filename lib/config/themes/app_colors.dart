import 'package:flutter/material.dart';

/// Brand tokens. The first eight come from docs/HANDOVER.md; the rest were
/// sampled from the exported Figma screens (their names are inferred from
/// where they're used — confirm against the Figma styles).
///
/// Still pending from the design: nightCard, nightInk, nightMuted, nightLine.
abstract final class AppColors {
  /// Main background.
  static const paper = Color(0xFFF6F2E7);

  /// Soft fills, chips.
  static const greenPale = Color(0xFFDCE7DF);

  /// Secondary.
  static const greenMid = Color(0xFF5C8A72);

  /// Primary: buttons, app-icon background.
  static const green = Color(0xFF35634F);

  /// Strong text and surfaces.
  static const greenDeep = Color(0xFF1E3A2E);

  /// Accent: the star, "open now" states.
  static const honey = Color(0xFFC4873D);

  /// Night-mode background.
  static const night = Color(0xFF16221C);

  /// Body text.
  static const ink = Color(0xFF22352C);

  /// Raised surfaces (selected cards), text on green buttons.
  static const paperSoft = Color(0xFFFFFDF6);

  /// Recessed rows, e.g. the calculation-method row.
  static const paperWarm = Color(0xFFEDE7D6);

  /// Hairlines: card borders, inactive page dots.
  static const line = Color(0xFFDDD6C4);

  /// Honey-tinted fill, e.g. behind the current step's number.
  static const honeyPale = Color(0xFFF2E3CC);

  /// Secondary text: subtitles, labels, descriptions.
  static const muted = Color(0xFF7A8C80);

  /// Tertiary text and unselected radio rings.
  static const faint = Color(0xFFA4B3A8);

  /// Softer body text, e.g. a dua's meaning.
  static const inkSoft = Color(0xFF4A5F53);
}
