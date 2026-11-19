import 'package:flutter/widgets.dart';

/// The star from the app's logo (`branding/ijaba_logo.svg`, its honey
/// four-point star), on its own: a done day in the week tracker, the days
/// card's halo. [height] sets its size; it's 20 : 24, a little tall.
class LogoStar extends StatelessWidget {
  const LogoStar({required this.height, required this.color, super.key});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size(height * 20 / 24, height),
    painter: _LogoStarPainter(color),
  );
}

class _LogoStarPainter extends CustomPainter {
  const _LogoStarPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // The logo's path (its star spans x 40–60, y 30–54), moved to the
    // origin and scaled to fit.
    canvas
      ..scale(size.width / 20, size.height / 24)
      ..translate(-40, -30);
    final path = Path()
      ..moveTo(50, 30)
      ..cubicTo(51.1, 37.6, 52.4, 40.9, 60, 42)
      ..cubicTo(52.4, 43.1, 51.1, 46.4, 50, 54)
      ..cubicTo(48.9, 46.4, 47.6, 43.1, 40, 42)
      ..cubicTo(47.6, 40.9, 48.9, 37.6, 50, 30)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_LogoStarPainter old) => old.color != color;
}
