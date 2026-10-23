import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:easy_localization/easy_localization.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Computes prayer times on the device with the Adhan algorithm — no network,
/// so the location never leaves the phone.
class PrayerTimesCalculator {
  const PrayerTimesCalculator();

  /// Prayer times for the calendar day of [date] (its time of day and time
  /// zone are ignored) at [location].
  ///
  /// Throws [CalculationFailure] where valid times can't be computed (inside
  /// the polar circles); callers wrap this in `guard()`.
  PrayerDay calculate({
    required DateTime date,
    required GeoPoint location,
    required PrayerSettings settings,
  }) {
    final day = DateTime.utc(date.year, date.month, date.day);
    final coordinates = adhan.Coordinates(
      location.latitude,
      location.longitude,
    );
    final parameters = _parameters(settings);
    final today = _prayerTimes(day, coordinates, parameters);
    final tomorrow = _prayerTimes(
      day.add(const Duration(days: 1)),
      coordinates,
      parameters,
    );

    final prayerDay = PrayerDay(
      date: day,
      fajr: today.fajr,
      sunrise: today.sunrise,
      dhuhr: today.dhuhr,
      asr: today.asr,
      maghrib: today.maghrib,
      isha: today.isha,
      nextFajr: tomorrow.fajr,
    );
    _ensureInPrayerOrder(prayerDay);
    return prayerDay;
  }

  // adhan_dart finds neighbouring days by adding 24 hours to the date. On a
  // local midnight that stays on the same day when DST ends (Egypt observes
  // DST), so always hand it noon UTC: no DST, and the date is unambiguous.
  adhan.PrayerTimes _prayerTimes(
    DateTime day,
    adhan.Coordinates coordinates,
    adhan.CalculationParameters parameters,
  ) => adhan.PrayerTimes(
    date: DateTime.utc(day.year, day.month, day.day, 12),
    coordinates: coordinates,
    calculationParameters: parameters,
  );

  /// Inside the polar circles the sun may not rise or set, and adhan_dart
  /// then returns times on unrelated dates (its polar-resolution options
  /// don't take effect as of 2.0.1). Refuse rather than schedule nonsense.
  void _ensureInPrayerOrder(PrayerDay day) {
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
      if (!times[i].isAfter(times[i - 1])) {
        throw CalculationFailure(LocaleKeys.errors_location_unsupported.tr());
      }
    }
  }

  adhan.CalculationParameters _parameters(PrayerSettings settings) =>
      _methodParameters(settings.method)
        ..madhab = settings.madhab
        ..adjustments = {
          for (final MapEntry(:key, :value) in settings.adjustments.entries)
            _adhanPrayer(key): value,
        };

  adhan.CalculationParameters _methodParameters(
    adhan.CalculationMethod method,
  ) => switch (method) {
    adhan.CalculationMethod.algerian =>
      adhan.CalculationMethodParameters.algerian(),
    adhan.CalculationMethod.dubai => adhan.CalculationMethodParameters.dubai(),
    adhan.CalculationMethod.egyptian =>
      adhan.CalculationMethodParameters.egyptian(),
    adhan.CalculationMethod.france =>
      adhan.CalculationMethodParameters.france(),
    adhan.CalculationMethod.gulfRegion =>
      adhan.CalculationMethodParameters.gulfRegion(),
    adhan.CalculationMethod.indonesian =>
      adhan.CalculationMethodParameters.indonesian(),
    adhan.CalculationMethod.jafari =>
      adhan.CalculationMethodParameters.jafari(),
    adhan.CalculationMethod.jordan =>
      adhan.CalculationMethodParameters.jordan(),
    adhan.CalculationMethod.karachi =>
      adhan.CalculationMethodParameters.karachi(),
    adhan.CalculationMethod.kuwait =>
      adhan.CalculationMethodParameters.kuwait(),
    adhan.CalculationMethod.moonsightingCommittee =>
      adhan.CalculationMethodParameters.moonsightingCommittee(),
    adhan.CalculationMethod.morocco =>
      adhan.CalculationMethodParameters.morocco(),
    adhan.CalculationMethod.muslimWorldLeague =>
      adhan.CalculationMethodParameters.muslimWorldLeague(),
    adhan.CalculationMethod.northAmerica =>
      adhan.CalculationMethodParameters.northAmerica(),
    adhan.CalculationMethod.other => adhan.CalculationMethodParameters.other(),
    adhan.CalculationMethod.portugal =>
      adhan.CalculationMethodParameters.portugal(),
    adhan.CalculationMethod.qatar => adhan.CalculationMethodParameters.qatar(),
    adhan.CalculationMethod.russia =>
      adhan.CalculationMethodParameters.russia(),
    adhan.CalculationMethod.singapore =>
      adhan.CalculationMethodParameters.singapore(),
    adhan.CalculationMethod.tehran =>
      adhan.CalculationMethodParameters.tehran(),
    adhan.CalculationMethod.tunisia =>
      adhan.CalculationMethodParameters.tunisia(),
    adhan.CalculationMethod.turkiye =>
      adhan.CalculationMethodParameters.turkiye(),
    adhan.CalculationMethod.ummAlQura =>
      adhan.CalculationMethodParameters.ummAlQura(),
  };

  adhan.Prayer _adhanPrayer(Prayer prayer) => switch (prayer) {
    Prayer.fajr => adhan.Prayer.fajr,
    Prayer.dhuhr => adhan.Prayer.dhuhr,
    Prayer.asr => adhan.Prayer.asr,
    Prayer.maghrib => adhan.Prayer.maghrib,
    Prayer.isha => adhan.Prayer.isha,
  };
}
