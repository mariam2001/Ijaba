import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/window_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'window_config_controller.g.dart';

/// The iqama and prayer timings windows are built from, as set in Settings.
@Riverpod(keepAlive: true)
WindowConfig windowConfig(Ref ref) => ref.watch(windowConfigControllerProvider);

@Riverpod(keepAlive: true)
class WindowConfigController extends _$WindowConfigController {
  /// Bounds, in minutes.
  static const iqamaRange = (min: 0, max: 60);
  static const prayerRange = (min: 5, max: 30);
  static const afterPrayerRange = (min: 5, max: 60);

  @override
  WindowConfig build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.windowConfig);
    return saved == null
        ? const WindowConfig()
        : WindowConfig.fromJson(jsonDecode(saved) as Json);
  }

  /// Moves [prayer]'s iqama by [delta] minutes from its latest value.
  Future<void> nudgeIqama(Prayer prayer, int delta) => _save(
    state.copyWith(
      iqamaDelays: {
        ...state.iqamaDelays,
        prayer: _minutes(
          state.iqamaDelay(prayer).inMinutes + delta,
          iqamaRange,
        ),
      },
    ),
  );

  Future<void> nudgePrayerDuration(int delta) => _save(
    state.copyWith(
      prayerDuration: _minutes(
        state.prayerDuration.inMinutes + delta,
        prayerRange,
      ),
    ),
  );

  Future<void> nudgeAfterPrayerDuration(int delta) => _save(
    state.copyWith(
      afterPrayerDuration: _minutes(
        state.afterPrayerDuration.inMinutes + delta,
        afterPrayerRange,
      ),
    ),
  );

  Future<void> reset() => _save(const WindowConfig());

  static Duration _minutes(int value, ({int min, int max}) range) =>
      Duration(minutes: value.clamp(range.min, range.max));

  Future<void> _save(WindowConfig config) async {
    state = config;
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.windowConfig, jsonEncode(config.toJson()));
  }
}
