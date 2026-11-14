import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/settings/presentation/controller/theme_controller.dart';

import '../../helpers/fakes.dart';

void main() {
  ProviderContainer container({
    MemoryCache? cache,
    DateTime? now,
    GeoPoint? location,
  }) {
    final container = ProviderContainer(
      overrides: [
        SimpleCache.provider.overrideWithValue(cache ?? MemoryCache()),
        prayerLocationProvider.overrideWithValue(location),
        if (now != null) clockProvider.overrideWith((ref) => Stream.value(now)),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('follows the phone by default', () {
    final c = container();

    expect(c.read(themeControllerProvider), ThemePreference.system);
    expect(c.read(themeModeProvider), ThemeMode.system);
  });

  test('restores and saves the choice', () async {
    final cache = MemoryCache();
    await cache.write(CacheKey.themeMode, 'dark');
    final c = container(cache: cache);

    expect(c.read(themeModeProvider), ThemeMode.dark);

    await c
        .read(themeControllerProvider.notifier)
        .setPreference(ThemePreference.light);

    expect(c.read(themeModeProvider), ThemeMode.light);
    expect(cache.read(CacheKey.themeMode), 'light');
  });

  group('after Maghrib (Alexandria, 1 June 2026)', () {
    // Maghrib there is about 17:00 UTC, sunrise about 03:00 UTC.
    const alexandria = GeoPoint(latitude: 31.2001, longitude: 29.9187);

    Future<ThemeMode> modeAt(DateTime now, {GeoPoint? location}) async {
      final cache = MemoryCache();
      await cache.write(CacheKey.themeMode, 'afterMaghrib');
      final c = container(cache: cache, now: now, location: location);
      // Listened to, so Riverpod runs the clock (unlistened providers pause).
      c.listen(clockProvider, (_, _) {});
      await c.read(clockProvider.future);
      return c.read(themeModeProvider);
    }

    test('light in the afternoon', () async {
      expect(
        await modeAt(DateTime.utc(2026, 6, 1, 12), location: alexandria),
        ThemeMode.light,
      );
    });

    test('night after Maghrib and before sunrise', () async {
      expect(
        await modeAt(DateTime.utc(2026, 6, 1, 18, 30), location: alexandria),
        ThemeMode.dark,
      );
      expect(
        await modeAt(DateTime.utc(2026, 6, 1, 1), location: alexandria),
        ThemeMode.dark,
      );
    });

    test('follows the phone until a location is set', () async {
      expect(
        await modeAt(DateTime.utc(2026, 6, 1, 18, 30)),
        ThemeMode.system,
      );
    });
  });
}
