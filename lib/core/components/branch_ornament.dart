import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The thin branch with two leaves under the splash wordmark, the welcome
/// illustration and each dua.
///
/// The Figma vector (`assets/brand/branch_ornament.svg`), tinted with
/// [color] (the design draws it at 45% opacity: pass that in the colour).
class BranchOrnament extends StatelessWidget {
  const BranchOrnament({required this.width, required this.color, super.key});

  /// Width of the drawing; its height follows (about 146 : 21).
  final double width;
  final Color color;

  static const _aspect = 20.9 / 145.6;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/brand/branch_ornament.svg',
    width: width,
    height: width * _aspect,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
