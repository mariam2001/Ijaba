import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/alerts/data/model/alert_payload.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

void main() {
  test('carries the window names', () {
    final payload = AlertPayload.encode([
      DuaWindowType.adhanToIqama,
      DuaWindowType.morningAdhkar,
    ]);

    expect(payload, 'adhanToIqama,morningAdhkar');
    expect(AlertPayload.windowToOpen('fridayHour'), DuaWindowType.fridayHour);
  });

  test('of windows sharing an alert, opens the one Home would feature', () {
    expect(
      AlertPayload.windowToOpen('adhanToIqama,morningAdhkar'),
      DuaWindowType.adhanToIqama,
    );
    expect(
      AlertPayload.windowToOpen('eveningAdhkar,fridayHour'),
      DuaWindowType.fridayHour,
    );
  });

  test('ignores anything else', () {
    expect(AlertPayload.windowToOpen(null), isNull);
    expect(AlertPayload.windowToOpen(''), isNull);
    expect(AlertPayload.windowToOpen('rain'), isNull);
    expect(
      AlertPayload.windowToOpen('rain,lastThirdOfNight'),
      DuaWindowType.lastThirdOfNight,
    );
  });
}
