import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';

part 'window_config.freezed.dart';

/// Timings no fixed rule sets — they vary by mosque and country — so the
/// user can change them in Settings ("Iqama & prayer"). The defaults are
/// common Egyptian practice.
@freezed
abstract class WindowConfig with _$WindowConfig {
  const WindowConfig._();

  const factory WindowConfig({
    /// Time from the adhan to the iqama.
    @Default(<Prayer, Duration>{
      Prayer.fajr: Duration(minutes: 20),
      Prayer.dhuhr: Duration(minutes: 15),
      Prayer.asr: Duration(minutes: 15),
      Prayer.maghrib: Duration(minutes: 10),
      Prayer.isha: Duration(minutes: 15),
    })
    Map<Prayer, Duration> iqamaDelays,

    /// Length of the congregational prayer; the after-prayer window opens
    /// when it ends (iqama + this).
    @Default(Duration(minutes: 10)) Duration prayerDuration,

    /// How long the after-prayer window stays open.
    @Default(Duration(minutes: 20)) Duration afterPrayerDuration,
  }) = _WindowConfig;

  /// Stored in whole minutes; anything missing or unknown falls back to the
  /// defaults.
  factory WindowConfig.fromJson(Json json) {
    const defaults = WindowConfig();
    Duration? minutes(Object? value) =>
        value is int ? Duration(minutes: value) : null;
    final saved = (json['iqamaDelays'] as Json?) ?? const {};
    return WindowConfig(
      iqamaDelays: {
        for (final prayer in Prayer.values)
          prayer: minutes(saved[prayer.name]) ?? defaults.iqamaDelay(prayer),
      },
      prayerDuration:
          minutes(json['prayerDuration']) ?? defaults.prayerDuration,
      afterPrayerDuration:
          minutes(json['afterPrayerDuration']) ?? defaults.afterPrayerDuration,
    );
  }

  Json toJson() => {
    'iqamaDelays': {
      for (final MapEntry(:key, :value) in iqamaDelays.entries)
        key.name: value.inMinutes,
    },
    'prayerDuration': prayerDuration.inMinutes,
    'afterPrayerDuration': afterPrayerDuration.inMinutes,
  };

  Duration iqamaDelay(Prayer prayer) => iqamaDelays[prayer] ?? Duration.zero;
}
