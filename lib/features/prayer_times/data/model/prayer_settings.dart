import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';

part 'prayer_settings.freezed.dart';

/// The user-adjustable inputs of the prayer-time calculation. Defaults follow
/// the handover: Egyptian General Authority of Survey, Shafi'i Asr.
@freezed
abstract class PrayerSettings with _$PrayerSettings {
  const factory PrayerSettings({
    @Default(CalculationMethod.egyptian) CalculationMethod method,
    @Default(Madhab.shafi) Madhab madhab,

    /// Manual correction per prayer, in minutes (Settings → time adjustment).
    @Default(<Prayer, int>{}) Map<Prayer, int> adjustments,
  }) = _PrayerSettings;
}
