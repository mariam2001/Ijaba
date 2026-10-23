import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';

void main() {
  const calculator = PrayerTimesCalculator();
  const cairo = GeoPoint(latitude: 30.028703, longitude: 31.249528);

  PrayerDay cairoDay({
    DateTime? date,
    PrayerSettings settings = const PrayerSettings(),
  }) => calculator.calculate(
    date: date ?? DateTime(2020),
    location: cairo,
    settings: settings,
  );

  test('matches the reference times for Cairo, 2020-01-01', () {
    // From the Adhan test suite (Egyptian method). Egypt was UTC+2 then, so
    // Fajr at 05:18 local is 03:18 UTC.
    final day = cairoDay();

    expect(day.fajr, DateTime.utc(2020, 1, 1, 3, 18));
    expect(day.sunrise, DateTime.utc(2020, 1, 1, 4, 51));
    expect(day.dhuhr, DateTime.utc(2020, 1, 1, 9, 59));
    expect(day.asr, DateTime.utc(2020, 1, 1, 12, 47));
    expect(day.maghrib, DateTime.utc(2020, 1, 1, 15, 6));
    expect(day.isha, DateTime.utc(2020, 1, 1, 16, 29));
  });

  test("nextFajr is the following day's Fajr", () {
    expect(cairoDay().nextFajr, cairoDay(date: DateTime(2020, 1, 2)).fajr);
  });

  test('uses only the calendar date of the input', () {
    expect(cairoDay(date: DateTime(2020, 1, 1, 23, 59)), cairoDay());
    expect(cairoDay(date: DateTime.utc(2020, 1, 1, 0, 1)), cairoDay());
  });

  test("Hanafi Asr is later than Shafi'i Asr; nothing else changes", () {
    final shafii = cairoDay();
    final hanafi = cairoDay(
      settings: const PrayerSettings(madhab: Madhab.hanafi),
    );

    expect(hanafi.asr.isAfter(shafii.asr), isTrue);
    expect(hanafi.copyWith(asr: shafii.asr), shafii);
  });

  test('manual adjustments shift only the adjusted prayers', () {
    final base = cairoDay();
    final adjusted = cairoDay(
      settings: const PrayerSettings(
        adjustments: {Prayer.fajr: 3, Prayer.isha: -2},
      ),
    );

    expect(adjusted.fajr, base.fajr.add(const Duration(minutes: 3)));
    expect(adjusted.isha, base.isha.subtract(const Duration(minutes: 2)));
    expect(adjusted.dhuhr, base.dhuhr);
    expect(adjusted.maghrib, base.maghrib);
  });

  test('every calculation method produces times in prayer order', () {
    // `other` has no angles of its own; it only makes sense with custom ones.
    final methods = CalculationMethod.values.where(
      (method) => method != CalculationMethod.other,
    );
    for (final method in methods) {
      final day = cairoDay(settings: PrayerSettings(method: method));
      final times = [
        day.fajr,
        day.sunrise,
        day.dhuhr,
        day.asr,
        day.maghrib,
        day.isha,
        day.nextFajr,
      ];
      for (var i = 1; i < times.length; i++) {
        expect(
          times[i].isAfter(times[i - 1]),
          isTrue,
          reason: '${method.name}: time $i is not after time ${i - 1}',
        );
      }
    }
  });

  group('inside the Arctic circle (Tromsø)', () {
    const tromso = GeoPoint(latitude: 69.65, longitude: 18.96);

    PrayerDay tromsoDay(DateTime date) => calculator.calculate(
      date: date,
      location: tromso,
      settings: const PrayerSettings(),
    );

    test('fails clearly during midnight sun and polar night', () {
      for (final date in [DateTime(2026, 6, 21), DateTime(2026, 12, 21)]) {
        expect(
          () => tromsoDay(date),
          throwsA(isA<CalculationFailure>()),
          reason: '$date',
        );
      }
    });

    test('works around the equinox, when the sun rises and sets', () {
      final day = tromsoDay(DateTime(2026, 3, 21));

      expect(day.nextFajr.isAfter(day.maghrib), isTrue);
    });
  });
}
