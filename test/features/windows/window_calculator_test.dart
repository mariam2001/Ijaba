import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:ijaba/features/windows/data/datasource/window_calculator.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

import '../../helpers/synthetic_day.dart';

void main() {
  const calculator = WindowCalculator();
  final saturday = syntheticDay(2026, 10, 24);
  final friday = syntheticDay(2026, 10, 23);

  List<DuaWindow> ofType(PrayerDay day, DuaWindowType type) => calculator
      .windowsFor(day)
      .where((window) => window.type == type)
      .toList();

  test('last third of the night: 2/3 of Maghrib→Fajr until Fajr', () {
    expect(ofType(saturday, DuaWindowType.lastThirdOfNight), [
      DuaWindow(
        type: DuaWindowType.lastThirdOfNight,
        start: DateTime.utc(2026, 10, 25, 1),
        end: DateTime.utc(2026, 10, 25, 5),
      ),
    ]);
  });

  test('adhan to iqama: Fajr and Maghrib only', () {
    expect(ofType(saturday, DuaWindowType.adhanToIqama), [
      DuaWindow(
        type: DuaWindowType.adhanToIqama,
        start: DateTime.utc(2026, 10, 24, 5),
        end: DateTime.utc(2026, 10, 24, 5, 20),
        prayer: Prayer.fajr,
      ),
      DuaWindow(
        type: DuaWindowType.adhanToIqama,
        start: DateTime.utc(2026, 10, 24, 17),
        end: DateTime.utc(2026, 10, 24, 17, 10),
        prayer: Prayer.maghrib,
      ),
    ]);
  });

  test('after prayer: one window per prayer, opening as the prayer ends', () {
    final windows = ofType(saturday, DuaWindowType.afterPrayer);

    expect(windows.map((window) => window.prayer), Prayer.values);
    // Fajr: adhan 05:00 + iqama 20 min + prayer 10 min, open for 20 min.
    expect(windows.first.start, DateTime.utc(2026, 10, 24, 5, 30));
    expect(windows.first.end, DateTime.utc(2026, 10, 24, 5, 50));
  });

  test("Friday's hour: the last hour before Maghrib, on Fridays only", () {
    expect(ofType(saturday, DuaWindowType.fridayHour), isEmpty);
    expect(ofType(friday, DuaWindowType.fridayHour), [
      DuaWindow(
        type: DuaWindowType.fridayHour,
        start: DateTime.utc(2026, 10, 23, 16),
        end: DateTime.utc(2026, 10, 23, 17),
      ),
    ]);
  });

  test('adhkar: Fajr→sunrise in the morning, Asr→Maghrib in the evening', () {
    expect(
      ofType(saturday, DuaWindowType.morningAdhkar).single.start,
      saturday.fajr,
    );
    expect(
      ofType(saturday, DuaWindowType.morningAdhkar).single.end,
      saturday.sunrise,
    );
    expect(
      ofType(saturday, DuaWindowType.eveningAdhkar).single.start,
      saturday.asr,
    );
    expect(
      ofType(saturday, DuaWindowType.eveningAdhkar).single.end,
      saturday.maghrib,
    );
  });

  test('windows come sorted by start', () {
    final starts = calculator.windowsFor(friday).map((window) => window.start);

    expect(starts, orderedEquals(starts.toList()..sort()));
  });

  test('isOpenAt includes the start and excludes the end', () {
    final window = ofType(saturday, DuaWindowType.lastThirdOfNight).single;

    expect(window.isOpenAt(window.start), isTrue);
    expect(
      window.isOpenAt(window.end.subtract(const Duration(seconds: 1))),
      isTrue,
    );
    expect(window.isOpenAt(window.end), isFalse);
    expect(
      window.isOpenAt(window.start.subtract(const Duration(seconds: 1))),
      isFalse,
    );
  });

  test("real Cairo night agrees with Adhan's own last-third time", () {
    const cairo = GeoPoint(latitude: 30.028703, longitude: 31.249528);
    final day = const PrayerTimesCalculator().calculate(
      date: DateTime(2020),
      location: cairo,
      settings: const PrayerSettings(),
    );
    final reference = adhan.SunnahTimes(
      adhan.PrayerTimes(
        date: DateTime.utc(2020, 1, 1, 12),
        coordinates: const adhan.Coordinates(30.028703, 31.249528),
        calculationParameters: adhan.CalculationMethodParameters.egyptian(),
      ),
    ).lastThirdOfTheNight;

    final start = ofType(day, DuaWindowType.lastThirdOfNight).single.start;

    expect(start.difference(reference).inSeconds.abs(), lessThanOrEqualTo(60));
  });
}
