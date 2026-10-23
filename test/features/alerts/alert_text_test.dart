import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_text.dart';
import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

import '../../helpers/synthetic_day.dart';

void main() {
  // Echo keys and arguments, so the test checks which strings are chosen.
  final text = AlertText(
    translate: (key, {namedArgs}) => namedArgs == null ? key : '$key$namedArgs',
    formatTime: (instant) =>
        '${instant.hour}:${instant.minute.toString().padLeft(2, '0')}',
  );
  final alerts = const AlertPlanner().plan(
    days: [syntheticDay(2026, 10, 24)],
    enabled: DuaWindowType.values.toSet(),
    now: DateTime.utc(2026, 10, 24),
  );

  PlannedAlert alertAt(int hour, [int minute = 0, int day = 24]) =>
      alerts.singleWhere(
        (alert) => alert.at == DateTime.utc(2026, 10, day, hour, minute),
      );

  test('a shared alert names every window, with its prayer', () {
    expect(
      text.title(alertAt(5)),
      'alerts.adhan_to_iqama_of{prayer: prayers.fajr} · windows.morning_adhkar',
    );
  });

  test('the last-third heads-up says when it begins', () {
    final heads = alertAt(0, 45, 25);

    expect(text.title(heads), 'windows.last_third');
    expect(text.body(heads), 'alerts.begins_at{time: 1:00}');
  });

  test('other alerts say until when the window stays open', () {
    // Friday-less Saturday at 15:00: evening adhkar, open until Maghrib.
    expect(text.body(alertAt(15)), 'alerts.open_until{time: 17:00}');
    expect(
      text.title(alertAt(12, 25)),
      'alerts.after_prayer_of{prayer: prayers.dhuhr}',
    );
  });
}
