import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/data/model/today_windows.dart';

import '../../helpers/synthetic_day.dart';

void main() {
  // Synthetic days: Fajr 05:00, sunrise 06:30, Dhuhr 12:00, Asr 15:00,
  // Maghrib 17:00, Isha 18:30; last third 01:00–05:00 the next morning.
  final days = [
    syntheticDay(2026, 10, 22),
    syntheticDay(2026, 10, 23), // a Friday
    syntheticDay(2026, 10, 24),
  ];
  final all = DuaWindowType.values.toSet();

  TodayWindows at(DateTime now, {Set<DuaWindowType>? enabled}) =>
      TodayWindows.at(now, days: days, enabled: enabled ?? all);

  test("yesterday's last third is open after midnight and featured", () {
    final today = at(DateTime.utc(2026, 10, 23, 2));

    expect(today.featured?.type, DuaWindowType.lastThirdOfNight);
    expect(today.featured?.end, DateTime.utc(2026, 10, 23, 5));
    expect(today.windows.first, today.featured);
  });

  test('lists open and upcoming windows for 24 hours, by start time', () {
    final now = DateTime.utc(2026, 10, 23, 2);
    final today = at(now);
    final starts = today.windows.map((window) => window.start).toList();

    expect(starts, orderedEquals([...starts]..sort()));
    expect(today.windows.every((window) => window.end.isAfter(now)), isTrue);
    expect(
      today.windows.every(
        (window) => window.start.isBefore(now.add(const Duration(hours: 24))),
      ),
      isTrue,
    );
  });

  test('overlapping windows: the Friday hour outranks evening adhkar', () {
    // 16:30 Friday: evening adhkar (15:00–17:00) and the Friday hour
    // (16:00–17:00) are both open.
    expect(
      at(DateTime.utc(2026, 10, 23, 16, 30)).featured?.type,
      DuaWindowType.fridayHour,
    );
  });

  test('with nothing open, the next window is featured', () {
    // 07:00: morning adhkar ended at sunrise; next is after Dhuhr at 12:25.
    final today = at(
      DateTime.utc(2026, 10, 23, 7),
      enabled: {DuaWindowType.afterPrayer},
    );

    expect(today.featured?.type, DuaWindowType.afterPrayer);
    expect(today.featured?.start, DateTime.utc(2026, 10, 23, 12, 25));
  });

  test('disabled windows are left out', () {
    final today = at(
      DateTime.utc(2026, 10, 23, 2),
      enabled: {DuaWindowType.fridayHour},
    );

    expect(
      today.windows.map((window) => window.type).toSet(),
      {DuaWindowType.fridayHour},
    );
  });
}
