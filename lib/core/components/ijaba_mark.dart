import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The in-app mark: a figure under an arch (Splash, Language, Welcome).
///
/// The Figma vector (Splash frame, node 9:4; exported to
/// `branding/figma/ijaba_mark.svg`), tinted with [color]; the shoulders keep
/// the design's lower opacity. As in Figma, the strokes keep their weight
/// (6.5 and 4.5 design px) at every size while the shape scales, so a small
/// mark isn't drawn thinner — which is why it's built here rather than
/// loaded as a fixed SVG.
class IjabaMark extends StatelessWidget {
  const IjabaMark({required this.width, required this.color, super.key});

  /// Width of the drawing, strokes included (the splash's is 68).
  final double width;
  final Color color;

  // The drawing in the 96-unit Figma frame: the arch's legs stand 61.44
  // apart and it spans 78.72 from its top to their feet.
  static const _span = 61.44;
  static const _rise = 78.72;

  @override
  Widget build(BuildContext context) {
    final arch = 6.5.r;
    // Frame units → pixels; the stroke sits half outside the path.
    final scale = (width - arch) / _span;
    final archWidth = arch / scale;
    final shoulderWidth = 4.5.r / scale;
    final half = archWidth / 2;
    final box = (
      x: 17.28 - half,
      y: 9.6 - half,
      w: _span + archWidth,
      h: _rise + archWidth,
    );
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" '
        'viewBox="${box.x} ${box.y} ${box.w} ${box.h}" fill="none">'
        '<path d="M17.28 88.32V44.16C17.28 24.96 30.72 9.6 48 9.6C65.28 9.6 '
        '78.72 24.96 78.72 44.16V88.32" stroke="#000" '
        'stroke-width="$archWidth" stroke-linecap="round" '
        'stroke-linejoin="round"/>'
        '<path d="M48 55.2C54.0972 55.2 59.04 50.2572 59.04 44.16C59.04 '
        '38.0628 54.0972 33.12 48 33.12C41.9028 33.12 36.96 38.0628 36.96 '
        '44.16C36.96 50.2572 41.9028 55.2 48 55.2Z" fill="#000"/>'
        '<path opacity="0.32" d="M34.56 67.2C34.56 59.52 40.32 53.76 48 '
        '53.76C55.68 53.76 61.44 59.52 61.44 67.2" stroke="#000" '
        'stroke-width="$shoulderWidth" stroke-linecap="round"/>'
        '</svg>';
    return SvgPicture.string(
      svg,
      width: width,
      height: width * box.h / box.w,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
