import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';

part 'prayer_settings.freezed.dart';

/// The user-adjustable inputs of the prayer-time calculation. Defaults follow
/// the handover: Egyptian General Authority of Survey, Shafi'i Asr.
@freezed
abstract class PrayerSettings with _$PrayerSettings {
  const PrayerSettings._();

  const factory PrayerSettings({
    @Default(CalculationMethod.egyptian) CalculationMethod method,
    @Default(Madhab.shafi) Madhab madhab,

    /// Manual correction per prayer, in minutes (Settings → time adjustment).
    @Default(<Prayer, int>{}) Map<Prayer, int> adjustments,
  }) = _PrayerSettings;

  /// Stored by enum names; unknown names fall back to the defaults.
  factory PrayerSettings.fromJson(Json json) {
    const defaults = PrayerSettings();
    final prayers = Prayer.values.asNameMap();
    return PrayerSettings(
      method:
          CalculationMethod.values.asNameMap()[json['method']] ??
          defaults.method,
      madhab: Madhab.values.asNameMap()[json['madhab']] ?? defaults.madhab,
      adjustments: {
        for (final MapEntry(:key, :value)
            in ((json['adjustments'] as Json?) ?? const {}).entries)
          ?prayers[key]: value as int,
      },
    );
  }

  Json toJson() => {
    'method': method.name,
    'madhab': madhab.name,
    'adjustments': {
      for (final MapEntry(:key, :value) in adjustments.entries)
        if (value != 0) key.name: value,
    },
  };

  /// [prayer]'s correction in minutes (0 when none).
  int adjustmentOf(Prayer prayer) => adjustments[prayer] ?? 0;
}
