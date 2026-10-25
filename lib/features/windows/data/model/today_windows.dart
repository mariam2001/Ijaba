import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/windows/data/datasource/window_calculator.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

/// What the Home screen shows at a given moment.
class TodayWindows {
  const TodayWindows({required this.windows, this.featured});

  /// From the enabled windows of [days]: those still open at [now] or
  /// starting within the next 24 hours, by start time. [days] should cover
  /// yesterday (its last third ends this morning) through tomorrow.
  factory TodayWindows.at(
    DateTime now, {
    required Iterable<PrayerDay> days,
    required Set<DuaWindowType> enabled,
    WindowCalculator calculator = const WindowCalculator(),
  }) {
    final horizon = now.add(const Duration(hours: 24));
    final windows = [
      for (final day in days)
        for (final window in calculator.windowsFor(day))
          if (enabled.contains(window.type) &&
              window.end.isAfter(now) &&
              window.start.isBefore(horizon))
            window,
    ]..sort((a, b) => a.start.compareTo(b.start));

    final open = windows.where((window) => window.isOpenAt(now)).toList()
      ..sort(
        (a, b) => featurePriority
            .indexOf(a.type)
            .compareTo(featurePriority.indexOf(b.type)),
      );
    return TodayWindows(
      windows: windows,
      featured: open.isNotEmpty ? open.first : windows.firstOrNull,
    );
  }

  /// Which open window the hero card shows when several overlap.
  static const featurePriority = [
    DuaWindowType.lastThirdOfNight,
    DuaWindowType.fridayHour,
    DuaWindowType.adhanToIqama,
    DuaWindowType.afterPrayer,
    DuaWindowType.morningAdhkar,
    DuaWindowType.eveningAdhkar,
  ];

  final List<DuaWindow> windows;

  /// The window to feature: the open one, or else the next to open.
  final DuaWindow? featured;
}
