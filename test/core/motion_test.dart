import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/core/components/motion.dart';

void main() {
  Widget app({required bool reduceMotion}) => MediaQuery(
    data: MediaQueryData(disableAnimations: reduceMotion),
    child: const Directionality(
      textDirection: TextDirection.rtl,
      child: Reveal(
        delay: Duration(milliseconds: 100),
        child: Text('x'),
      ),
    ),
  );

  double opacity(WidgetTester tester) =>
      tester.widget<Opacity>(find.byType(Opacity)).opacity;

  testWidgets('Reveal fades in after its delay, then rests fully shown', (
    tester,
  ) async {
    await tester.pumpWidget(app(reduceMotion: false));
    expect(opacity(tester), 0);

    await tester.pump(const Duration(milliseconds: 90));
    expect(opacity(tester), 0); // Still waiting out the delay.

    await tester.pump(const Duration(milliseconds: 200));
    expect(opacity(tester), inExclusiveRange(0, 1));

    await tester.pumpAndSettle();
    expect(opacity(tester), 1);
  });

  testWidgets('with the phone\'s "remove animations" on, nothing moves', (
    tester,
  ) async {
    await tester.pumpWidget(app(reduceMotion: true));
    expect(opacity(tester), 1);
    expect(
      Motion.of(tester.element(find.text('x')), Motion.long),
      Duration.zero,
    );
  });
}
