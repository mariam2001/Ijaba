import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';

import '../../helpers/fakes.dart';

void main() {
  ProviderContainer containerWith(MemoryCache cache) {
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('by default everything alerts except after-prayer', () {
    final enabled = containerWith(
      MemoryCache(),
    ).read(enabledWindowTypesProvider);

    expect(enabled, isNot(contains(DuaWindowType.afterPrayer)));
    expect(enabled, hasLength(DuaWindowType.values.length - 1));
  });

  test('switches are saved and survive a restart', () async {
    final cache = MemoryCache();
    final container = containerWith(cache);
    final notifier = container.read(enabledWindowTypesProvider.notifier);

    await notifier.setEnabled({
      DuaWindowType.morningAdhkar,
      DuaWindowType.eveningAdhkar,
    }, on: false);
    await notifier.setEnabled({DuaWindowType.afterPrayer}, on: true);

    const expected = {
      DuaWindowType.lastThirdOfNight,
      DuaWindowType.adhanToIqama,
      DuaWindowType.afterPrayer,
      DuaWindowType.fridayHour,
    };
    expect(container.read(enabledWindowTypesProvider), expected);
    expect(containerWith(cache).read(enabledWindowTypesProvider), expected);
  });

  test('unknown saved names are ignored', () async {
    final cache = MemoryCache();
    await cache.write(CacheKey.enabledWindows, '["fridayHour", "rain"]');

    expect(containerWith(cache).read(enabledWindowTypesProvider), {
      DuaWindowType.fridayHour,
    });
  });
}
