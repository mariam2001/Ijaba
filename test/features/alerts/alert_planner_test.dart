import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

import '../../helpers/synthetic_day.dart';

void main() {
  const planner = AlertPlanner();
  final friday = syntheticDay(2026, 10, 23);
  final saturday = syntheticDay(2026, 10, 24);
  final allTypes = DuaWindowType.values.toSet();

  List<PlannedAlert> plan({
    Set<DuaWindowType>? enabled,
    DateTime? now,
  }) => planner.plan(
    days: [friday, saturday],
    enabled: enabled ?? allTypes,
    now: now ?? DateTime.utc(2026, 10, 23),
  );

  PlannedAlert alertAt(List<PlannedAlert> alerts, DateTime at) =>
      alerts.singleWhere((alert) => alert.at == at);

  test('the last third gets a heads-up 15 minutes before it begins', () {
    // Saturday's last third starts Sunday 01:00.
    final alert = alertAt(plan(), DateTime.utc(2026, 10, 25, 0, 45));

    expect(alert.windows.single.type, DuaWindowType.lastThirdOfNight);
  });

  test('windows opening in the same minute share one alert', () {
    final fajr = alertAt(plan(), DateTime.utc(2026, 10, 24, 5));

    expect(fajr.windows.map((window) => window.type), [
      DuaWindowType.adhanToIqama,
      DuaWindowType.morningAdhkar,
    ]);
    expect(fajr.windows.first.prayer, Prayer.fajr);
  });

  test('alerts are sorted, unique, and keyed by minute since the epoch', () {
    final alerts = plan();
    final times = alerts.map((alert) => alert.at).toList();

    expect(times, orderedEquals([...times]..sort()));
    expect(alerts.map((alert) => alert.id).toSet(), hasLength(alerts.length));
    for (final alert in alerts) {
      expect(alert.id, alert.at.millisecondsSinceEpoch ~/ 60000);
    }
  });

  test('disabled windows are left out', () {
    final alerts = plan(enabled: {DuaWindowType.fridayHour});

    expect(alerts.single.at, DateTime.utc(2026, 10, 23, 16));
  });

  test('alerts at or before now are dropped', () {
    final alerts = plan(now: DateTime.utc(2026, 10, 24, 5));

    expect(
      alerts.every((alert) => alert.at.isAfter(DateTime.utc(2026, 10, 24, 5))),
      isTrue,
    );
  });

  test("yesterday's night is still planned after midnight", () {
    // 00:30 Saturday: Friday's last-third heads-up (00:45) is still ahead.
    final first = plan(now: DateTime.utc(2026, 10, 24, 0, 30)).first;

    expect(first.at, DateTime.utc(2026, 10, 24, 0, 45));
    expect(first.windows.single.type, DuaWindowType.lastThirdOfNight);
  });

  test('only alerts made up of after-prayer windows are quiet', () {
    final alerts = plan();
    final afterFajr = alertAt(alerts, DateTime.utc(2026, 10, 24, 5, 30));
    final fajr = alertAt(alerts, DateTime.utc(2026, 10, 24, 5));

    expect(afterFajr.isQuiet, isTrue);
    expect(fajr.isQuiet, isFalse);
  });
}
