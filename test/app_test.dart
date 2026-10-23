import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/core/controllers/theme_controller.dart';
import 'package:ijaba/core/service/local/cache/base_cache.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MemoryCache implements BaseCache {
  final _values = <CacheKey, String>{};

  @override
  String? read(CacheKey key) => _values[key];

  @override
  Future<void> write(CacheKey key, String value) async => _values[key] = value;

  @override
  Future<void> delete(CacheKey key) async => _values.remove(key);

  @override
  Future<void> clear() async => _values.clear();
}

void main() {
  setUpAll(() async {
    // easy_localization persists the chosen locale via SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('boots to the localized home page', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [SimpleCache.provider.overrideWithValue(_MemoryCache())],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Ijaba'), findsOneWidget);
  });

  test('ThemeController restores and saves the chosen theme', () async {
    final cache = _MemoryCache();
    await cache.write(CacheKey.themeMode, ThemeMode.dark.name);
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);

    expect(container.read(themeControllerProvider), ThemeMode.dark);

    await container
        .read(themeControllerProvider.notifier)
        .setThemeMode(ThemeMode.light);

    expect(container.read(themeControllerProvider), ThemeMode.light);
    expect(cache.read(CacheKey.themeMode), ThemeMode.light.name);
  });
}
