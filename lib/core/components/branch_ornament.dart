import 'package:flutter/material.dart';

/// The thin branch with two leaves used under the splash wordmark and the
/// welcome illustration.
///
/// An approximation drawn from the Figma export (146 × 21 artboard) until
/// the original SVG is available.
class BranchOrnament extends StatelessWidget {
  const BranchOrnament({required this.width, required this.color, super.key});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size(width, width * _BranchPainter.height / _BranchPainter.width),
    painter: _BranchPainter(color),
  );
}

class _BranchPainter extends CustomPainter {
  _BranchPainter(this.color);

  static const width = 146.0;
  static const height = 21.0;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / width);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color;

    canvas.drawPath(
      Path()
        ..moveTo(0, 20)
        ..quadraticBezierTo(73, 0, 146, 20),
      stroke,
    );

    // Two leaves opening upwards from the centre.
    for (final side in const [-1.0, 1.0]) {
      canvas
        ..save()
        ..translate(73, 9)
        ..rotate(side * 0.75)
        ..drawOval(
          Rect.fromCenter(center: const Offset(0, -4.5), width: 5, height: 11),
          fill,
        )
        ..restore();
    }

    // Small buds along the branch.
    for (final x in const [36.0, 110.0]) {
      final y = 20 - 20 * (1 - ((x - 73) / 73) * ((x - 73) / 73)) * 0.5;
      canvas.drawCircle(Offset(x, y - 1.5), 1.6, fill);
    }
  }

  @override
  bool shouldRepaint(_BranchPainter oldDelegate) => oldDelegate.color != color;
}
