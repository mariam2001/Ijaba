import 'dart:collection';

import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/windows/data/datasource/window_calculator.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

/// Decides which notifications to schedule for a run of days.
class AlertPlanner {
  const AlertPlanner({
    this.windowCalculator = const WindowCalculator(),
    this.leadTimes = defaultLeadTimes,
  });

  final WindowCalculator windowCalculator;

  /// How long before a window opens its alert fires; windows not listed
  /// alert as they open. From the design: a heads-up 15 minutes before the
  /// last third, and 5 minutes before the adhan.
  final Map<DuaWindowType, Duration> leadTimes;

  static const defaultLeadTimes = {
    DuaWindowType.lastThirdOfNight: Duration(minutes: 15),
    DuaWindowType.adhanToIqama: Duration(minutes: 5),
  };

  Duration leadTimeOf(DuaWindowType type) => leadTimes[type] ?? Duration.zero;

  DateTime alertTimeOf(DuaWindow window) =>
      window.start.subtract(leadTimeOf(window.type));

  /// Alerts for the [enabled] windows of [days] that fire after [now],
  /// sorted by time. Alert times are floored to the minute.
  List<PlannedAlert> plan({
    required Iterable<PrayerDay> days,
    required Set<DuaWindowType> enabled,
    required DateTime now,
  }) {
    final windowsByMinute = SplayTreeMap<int, List<DuaWindow>>();
    for (final day in days) {
      for (final window in windowCalculator.windowsFor(day)) {
        if (!enabled.contains(window.type)) continue;
        final minute =
            alertTimeOf(window).millisecondsSinceEpoch ~/
            Duration.millisecondsPerMinute;
        if (!_atMinute(minute).isAfter(now)) continue;
        windowsByMinute.putIfAbsent(minute, () => []).add(window);
      }
    }

    return [
      for (final MapEntry(key: minute, value: windows)
          in windowsByMinute.entries)
        PlannedAlert(
          id: minute,
          at: _atMinute(minute),
          windows: windows
            ..sort((a, b) => a.type.index.compareTo(b.type.index)),
        ),
    ];
  }

  DateTime _atMinute(int minute) => DateTime.fromMillisecondsSinceEpoch(
    minute * Duration.millisecondsPerMinute,
    isUtc: true,
  );
}
