import 'package:flutter/widgets.dart';

/// A four-pointed sparkle, as around the design's halos.
class Sparkle extends StatelessWidget {
  const Sparkle({required this.size, required this.color, super.key});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size.square(size),
    painter: _SparklePainter(color),
  );
}

class _SparklePainter extends CustomPainter {
  const _SparklePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final c = w / 2;
    // Concave sides: each point is reached by a curve through the centre's
    // neighbourhood.
    final path = Path()
      ..moveTo(c, 0)
      ..quadraticBezierTo(c, c, w, c)
      ..quadraticBezierTo(c, c, c, w)
      ..quadraticBezierTo(c, c, 0, c)
      ..quadraticBezierTo(c, c, c, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_SparklePainter old) => old.color != color;
}
