import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/core/controllers/theme_controller.dart';
import 'package:ijaba/core/service/local/cache/base_cache.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records what the app schedules instead of talking to Android.
class _FakeNotifications extends Fake implements NotificationService {
  final scheduled = <({int id, String title, bool quiet})>[];

  @override
  Future<bool> canScheduleExactAlarms() async => true;

  @override
  Future<void> ensureChannels({
    required String name,
    required String quietName,
  }) async {}

  @override
  Future<void> cancelWindowAlerts() async => scheduled.clear();

  @override
  Future<void> schedule({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    required AndroidScheduleMode mode,
    bool quiet = false,
    String? payload,
  }) async => scheduled.add((id: id, title: title, quiet: quiet));
}

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
    await initializeDateFormatting();
  });

  Future<_FakeNotifications> pumpApp(WidgetTester tester) async {
    final notifications = _FakeNotifications();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          SimpleCache.provider.overrideWithValue(_MemoryCache()),
          NotificationService.provider.overrideWithValue(notifications),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    return notifications;
  }

  testWidgets('boots to the home page in Arabic, right-to-left', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('إجابة'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(HomePage))),
      TextDirection.rtl,
    );
  });

  testWidgets('schedules the coming days of alerts at launch, in Arabic', (
    tester,
  ) async {
    final notifications = await pumpApp(tester);

    // ~10 alerts a day for 7 days (exact count depends on today's date).
    expect(notifications.scheduled.length, greaterThan(50));
    expect(
      notifications.scheduled.map((alert) => alert.title),
      contains('الثلث الأخير من الليل'),
    );
    expect(notifications.scheduled.any((alert) => alert.quiet), isTrue);
  });

  test('ThemeController defaults to light, ignoring the OS setting', () {
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(_MemoryCache())],
    );
    addTearDown(container.dispose);

    expect(container.read(themeControllerProvider), ThemeMode.light);
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
