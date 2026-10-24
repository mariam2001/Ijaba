import 'package:flutter/material.dart';

/// The in-app mark: a figure under an arch.
///
/// Drawn in code from measurements of the Figma export (a 68 × 85 artboard)
/// until the original SVG is available.
class IjabaMark extends StatelessWidget {
  const IjabaMark({
    required this.width,
    required this.color,
    this.headColor,
    super.key,
  });

  final double width;

  /// Arch and, unless [headColor] is given, the head. The shoulders use it
  /// at low opacity.
  final Color color;
  final Color? headColor;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size(width, width * _MarkPainter.height / _MarkPainter.width),
    painter: _MarkPainter(color: color, headColor: headColor ?? color),
  );
}

class _MarkPainter extends CustomPainter {
  _MarkPainter({required this.color, required this.headColor});

  static const width = 68.0;
  static const height = 85.0;

  final Color color;
  final Color headColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / width);

    final arch = Path()
      ..moveTo(3, 81)
      ..lineTo(3, 34)
      ..arcToPoint(const Offset(65, 34), radius: const Radius.circular(31))
      ..lineTo(65, 81);
    canvas.drawPath(
      arch,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawArc(
      Rect.fromCircle(center: const Offset(33.5, 62), radius: 13.5),
      3.14159265,
      3.14159265,
      false,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    canvas.drawCircle(
      const Offset(33.5, 37),
      10.5,
      Paint()..color = headColor,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.headColor != headColor;
}
