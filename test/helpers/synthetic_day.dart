import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';

/// A synthetic day with round times (UTC), so each rule is easy to check by
/// hand: Fajr 05:00, sunrise 06:30, Dhuhr 12:00, Asr 15:00, Maghrib 17:00,
/// Isha 18:30, next Fajr 05:00 — a 12-hour night.
PrayerDay syntheticDay(int year, int month, int dayOfMonth) {
  DateTime at(int hour, [int minute = 0, int addDays = 0]) =>
      DateTime.utc(year, month, dayOfMonth + addDays, hour, minute);
  return PrayerDay(
    date: DateTime.utc(year, month, dayOfMonth),
    fajr: at(5),
    sunrise: at(6, 30),
    dhuhr: at(12),
    asr: at(15),
    maghrib: at(17),
    isha: at(18, 30),
    nextFajr: at(5, 0, 1),
  );
}
