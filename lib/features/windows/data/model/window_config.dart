import 'package:ijaba/features/prayer_times/data/model/prayer.dart';

/// Timings the design doesn't pin down. Provisional — to be confirmed by
/// Mariam (iqama delays vary by country and mosque).
class WindowConfig {
  const WindowConfig({
    this.iqamaDelays = const {
      Prayer.fajr: Duration(minutes: 20),
      Prayer.dhuhr: Duration(minutes: 15),
      Prayer.asr: Duration(minutes: 15),
      Prayer.maghrib: Duration(minutes: 10),
      Prayer.isha: Duration(minutes: 15),
    },
    this.prayerDuration = const Duration(minutes: 10),
    this.afterPrayerDuration = const Duration(minutes: 20),
  });

  /// Time from the adhan to the iqama.
  final Map<Prayer, Duration> iqamaDelays;

  /// Length of the congregational prayer; the after-prayer window opens when
  /// it ends (iqama + this).
  final Duration prayerDuration;

  /// How long the after-prayer window stays open.
  final Duration afterPrayerDuration;

  Duration iqamaDelay(Prayer prayer) => iqamaDelays[prayer] ?? Duration.zero;
}
