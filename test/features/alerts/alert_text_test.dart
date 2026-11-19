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
    // With no heads-ups, the Fajr adhan and morning adhkar share 05:00.
    final shared = const AlertPlanner(leadTimes: {})
        .plan(
          days: [syntheticDay(2026, 10, 24)],
          enabled: DuaWindowType.values.toSet(),
          now: DateTime.utc(2026, 10, 24),
        )
        .singleWhere((alert) => alert.at == DateTime.utc(2026, 10, 24, 5));

    expect(
      text.title(shared),
      'alerts.adhan_to_iqama_of{prayer: prayers.fajr} · windows.morning_adhkar',
    );
  });

  test('the heads-up before the adhan says when the window begins', () {
    expect(text.body(alertAt(4, 55)), 'alerts.begins_at{time: 5:00}');
  });

  test('the last third is near, then has begun, in warm words', () {
    final heads = alertAt(0, 45, 25);
    expect(text.title(heads), 'warm_alerts.last_third_soon_title');
    expect(text.body(heads), 'warm_alerts.last_third_body');

    final opening = const AlertPlanner(leadTimes: {})
        .plan(
          days: [syntheticDay(2026, 10, 24)],
          enabled: const {DuaWindowType.lastThirdOfNight},
          now: DateTime.utc(2026, 10, 24),
        )
        .first;
    expect(text.title(opening), 'warm_alerts.last_third_title');
  });

  test('the Friday hour and morning adhkar alone have warm words too', () {
    final friday = const AlertPlanner()
        .plan(
          days: [syntheticDay(2026, 10, 23)],
          enabled: const {DuaWindowType.fridayHour},
          now: DateTime.utc(2026, 10, 23),
        )
        .single;
    expect(text.title(friday), 'warm_alerts.friday_title');
    expect(text.body(friday), 'warm_alerts.friday_body');

    final morning = const AlertPlanner()
        .plan(
          days: [syntheticDay(2026, 10, 24)],
          enabled: const {DuaWindowType.morningAdhkar},
          now: DateTime.utc(2026, 10, 24),
        )
        .single;
    expect(text.title(morning), 'warm_alerts.morning_title');
    expect(text.body(morning), 'warm_alerts.morning_body');
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
