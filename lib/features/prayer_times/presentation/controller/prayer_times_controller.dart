import 'dart:convert';

import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/presentation/controller/location_controller.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_times_controller.g.dart';

/// Where prayer times are calculated; null until onboarding saves a location.
@Riverpod(keepAlive: true)
GeoPoint? prayerLocation(Ref ref) =>
    ref.watch(locationControllerProvider)?.point;

/// Calculation settings, as chosen in Settings (stored on the device).
@Riverpod(keepAlive: true)
PrayerSettings prayerSettings(Ref ref) =>
    ref.watch(prayerSettingsControllerProvider);

@Riverpod(keepAlive: true)
class PrayerSettingsController extends _$PrayerSettingsController {
  /// Corrections stay within half an hour either way.
  static const maxAdjustment = 30;

  @override
  PrayerSettings build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.prayerSettings);
    return saved == null
        ? const PrayerSettings()
        : PrayerSettings.fromJson(jsonDecode(saved) as Json);
  }

  Future<void> setMethod(CalculationMethod method) =>
      _save(state.copyWith(method: method));

  Future<void> setMadhab(Madhab madhab) =>
      _save(state.copyWith(madhab: madhab));

  Future<void> setAdjustment(Prayer prayer, int minutes) => _save(
    state.copyWith(
      adjustments: {
        ...state.adjustments,
        prayer: minutes.clamp(-maxAdjustment, maxAdjustment),
      },
    ),
  );

  /// Moves [prayer]'s correction by [delta] minutes, from its latest value
  /// (so quick repeated taps all count).
  Future<void> nudgeAdjustment(Prayer prayer, int delta) =>
      setAdjustment(prayer, state.adjustmentOf(prayer) + delta);

  Future<void> _save(PrayerSettings settings) async {
    state = settings;
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.prayerSettings, jsonEncode(settings.toJson()));
  }
}
