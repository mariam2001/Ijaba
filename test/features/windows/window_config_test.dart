import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/datasource/window_calculator.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/data/model/window_config.dart';
import 'package:ijaba/features/windows/presentation/controller/window_config_controller.dart';

import '../../helpers/fakes.dart';
import '../../helpers/synthetic_day.dart';

void main() {
  ProviderContainer containerWith(MemoryCache cache) {
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('round-trips through JSON; missing values fall back', () {
    const config = WindowConfig(
      iqamaDelays: {
        Prayer.fajr: Duration(minutes: 25),
        Prayer.dhuhr: Duration(minutes: 15),
        Prayer.asr: Duration(minutes: 15),
        Prayer.maghrib: Duration(minutes: 5),
        Prayer.isha: Duration(minutes: 15),
      },
      prayerDuration: Duration(minutes: 12),
    );

    expect(WindowConfig.fromJson(config.toJson()), config);
    expect(WindowConfig.fromJson({}), const WindowConfig());
  });

  test('changes are saved, survive a restart, and stay in range', () async {
    final cache = MemoryCache();
    final controller = containerWith(
      cache,
    ).read(windowConfigControllerProvider.notifier);

    await controller.nudgeIqama(Prayer.maghrib, -15); // 10 → floor 0
    await controller.nudgePrayerDuration(3); // 10 → 13

    final restarted = containerWith(cache).read(windowConfigProvider);
    expect(restarted.iqamaDelay(Prayer.maghrib), Duration.zero);
    expect(restarted.prayerDuration, const Duration(minutes: 13));

    await controller.reset();
    expect(
      containerWith(cache).read(windowConfigProvider),
      const WindowConfig(),
    );
  });

  test('the windows follow the timings', () {
    // Synthetic Fajr 05:00; iqama 30 min after, 15-min prayer, 10-min
    // after-prayer window.
    const config = WindowConfig(
      iqamaDelays: {Prayer.fajr: Duration(minutes: 30)},
      prayerDuration: Duration(minutes: 15),
      afterPrayerDuration: Duration(minutes: 10),
    );
    final windows = const WindowCalculator(
      config: config,
    ).windowsFor(syntheticDay(2026, 10, 24));
    final adhan = windows.firstWhere(
      (w) => w.type == DuaWindowType.adhanToIqama && w.prayer == Prayer.fajr,
    );
    final after = windows.firstWhere(
      (w) => w.type == DuaWindowType.afterPrayer && w.prayer == Prayer.fajr,
    );

    expect(adhan.end, DateTime.utc(2026, 10, 24, 5, 30));
    expect(after.start, DateTime.utc(2026, 10, 24, 5, 45));
    expect(after.end, DateTime.utc(2026, 10, 24, 5, 55));
  });
}
