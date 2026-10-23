import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/data/model/window_config.dart';

/// Turns a day's prayer times into the dua windows of that day.
class WindowCalculator {
  const WindowCalculator({this.config = const WindowConfig()});

  final WindowConfig config;

  /// All windows belonging to [day], sorted by start. The last-third window
  /// is the night after this day's Maghrib, so it ends the next morning.
  List<DuaWindow> windowsFor(PrayerDay day) => [
    _lastThirdOfNight(day),
    for (final prayer in const [Prayer.fajr, Prayer.maghrib])
      DuaWindow(
        type: DuaWindowType.adhanToIqama,
        start: day.adhan(prayer),
        end: _iqama(day, prayer),
        prayer: prayer,
      ),
    for (final prayer in Prayer.values) _afterPrayer(day, prayer),
    if (day.date.weekday == DateTime.friday)
      DuaWindow(
        type: DuaWindowType.fridayHour,
        start: day.maghrib.subtract(const Duration(hours: 1)),
        end: day.maghrib,
      ),
    DuaWindow(
      type: DuaWindowType.morningAdhkar,
      start: day.fajr,
      end: day.sunrise,
    ),
    DuaWindow(
      type: DuaWindowType.eveningAdhkar,
      start: day.asr,
      end: day.maghrib,
    ),
  ]..sort((a, b) => a.start.compareTo(b.start));

  DuaWindow _lastThirdOfNight(PrayerDay day) {
    final night = day.nextFajr.difference(day.maghrib);
    return DuaWindow(
      type: DuaWindowType.lastThirdOfNight,
      start: day.maghrib.add(night * 2 ~/ 3),
      end: day.nextFajr,
    );
  }

  DuaWindow _afterPrayer(PrayerDay day, Prayer prayer) {
    final start = _iqama(day, prayer).add(config.prayerDuration);
    return DuaWindow(
      type: DuaWindowType.afterPrayer,
      start: start,
      end: start.add(config.afterPrayerDuration),
      prayer: prayer,
    );
  }

  DateTime _iqama(PrayerDay day, Prayer prayer) =>
      day.adhan(prayer).add(config.iqamaDelay(prayer));
}
