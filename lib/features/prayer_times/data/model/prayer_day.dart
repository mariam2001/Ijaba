import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';

part 'prayer_day.freezed.dart';

/// Prayer times for one calendar day. Every time is a UTC instant; call
/// `toLocal()` to display it.
@freezed
abstract class PrayerDay with _$PrayerDay {
  const PrayerDay._();

  const factory PrayerDay({
    /// The calendar day, as a UTC midnight (only the date part is meaningful).
    required DateTime date,
    required DateTime fajr,
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,

    /// Fajr of the following day, which ends this day's night.
    required DateTime nextFajr,
  }) = _PrayerDay;

  DateTime adhan(Prayer prayer) => switch (prayer) {
    Prayer.fajr => fajr,
    Prayer.dhuhr => dhuhr,
    Prayer.asr => asr,
    Prayer.maghrib => maghrib,
    Prayer.isha => isha,
  };
}
