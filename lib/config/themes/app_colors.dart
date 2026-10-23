import 'package:flutter/material.dart';

/// Brand tokens from the design (docs/HANDOVER.md).
///
/// The design also defines paperWarm, paperSoft, inkSoft, muted, faint,
/// honeyPale, line, nightCard, nightInk, nightMuted and nightLine. Their
/// values are pending from the designer — add them here, don't approximate.
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
}
