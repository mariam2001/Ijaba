import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';

/// The app's logo (the arch, the star and the raised hands —
/// `branding/ijaba_logo.svg`), in its own colours: green by day, the
/// reversed (paper) one by night or on green ([reversed]).
class IjabaLogo extends StatelessWidget {
  const IjabaLogo({required this.size, this.reversed, super.key});

  final double size;

  /// Null: follow the theme.
  final bool? reversed;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    (reversed ?? context.colors.isNight)
        ? 'assets/brand/ijaba_logo_reversed.svg'
        : 'assets/brand/ijaba_logo.svg',
    width: size,
    height: size,
  );
}
