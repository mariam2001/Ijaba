import 'package:adhan_dart/adhan_dart.dart' show CalculationMethod, Madhab;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';

import '../../helpers/fakes.dart';

void main() {
  ProviderContainer containerWith(MemoryCache cache) {
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('round-trips through JSON; unknown names fall back', () {
    const settings = PrayerSettings(
      method: CalculationMethod.ummAlQura,
      madhab: Madhab.hanafi,
      adjustments: {Prayer.fajr: 2, Prayer.isha: -3},
    );

    expect(PrayerSettings.fromJson(settings.toJson()), settings);
    expect(
      PrayerSettings.fromJson({
        'method': 'nonsense',
        'adjustments': {'brunch': 5},
      }),
      const PrayerSettings(),
    );
  });

  test('defaults to the Egyptian method and Shafi\'i Asr', () {
    final settings = containerWith(MemoryCache()).read(prayerSettingsProvider);

    expect(settings.method, CalculationMethod.egyptian);
    expect(settings.madhab, Madhab.shafi);
    expect(settings.adjustmentOf(Prayer.fajr), 0);
  });

  test(
    'changes are saved, survive a restart, and stay within 30 min',
    () async {
      final cache = MemoryCache();
      final container = containerWith(cache);
      final controller = container.read(
        prayerSettingsControllerProvider.notifier,
      );

      await controller.setMethod(CalculationMethod.muslimWorldLeague);
      await controller.setMadhab(Madhab.hanafi);
      await controller.setAdjustment(Prayer.maghrib, 99);

      expect(cache.read(CacheKey.prayerSettings), isNotNull);
      final restarted = containerWith(cache).read(prayerSettingsProvider);
      expect(restarted.method, CalculationMethod.muslimWorldLeague);
      expect(restarted.madhab, Madhab.hanafi);
      expect(restarted.adjustmentOf(Prayer.maghrib), 30);
    },
  );
}
