import 'dart:convert';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/core/controllers/theme_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';
import 'package:ijaba/features/onboarding/presentation/pages/language_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/splash_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

void main() {
  setUpAll(() async {
    // easy_localization persists the chosen locale via SharedPreferences.
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  /// Launches the app on a phone-sized screen and waits out the splash.
  Future<FakeNotifications> pumpApp(
    WidgetTester tester, {
    required MemoryCache cache,
  }) async {
    tester.view
      ..physicalSize = const Size(390, 844)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final notifications = FakeNotifications();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          SimpleCache.provider.overrideWithValue(cache),
          NotificationService.provider.overrideWithValue(notifications),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(SplashPage), findsOneWidget);
    await tester.pump(SplashPage.duration);
    await tester.pumpAndSettle();
    return notifications;
  }

  testWidgets('first launch: splash, then the language screen, in Arabic RTL', (
    tester,
  ) async {
    final notifications = await pumpApp(tester, cache: MemoryCache());

    expect(find.byType(LanguagePage), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(LanguagePage))),
      TextDirection.rtl,
    );
    // No location yet, so nothing to schedule.
    expect(notifications.scheduled, isEmpty);
  });

  testWidgets('after onboarding: opens Home and schedules the coming days', (
    tester,
  ) async {
    final cache = MemoryCache();
    await cache.write(CacheKey.onboardingDone, 'true');
    await cache.write(
      CacheKey.location,
      jsonEncode(
        const SavedLocation(latitude: 31.2001, longitude: 29.9187).toJson(),
      ),
    );

    final notifications = await pumpApp(tester, cache: cache);

    expect(find.byType(HomePage), findsOneWidget);
    // ~5 alerts a day for 7 days with the default switches (exact count
    // depends on today's date).
    expect(notifications.scheduled.length, greaterThan(25));
    expect(
      notifications.scheduled.map((alert) => alert.title),
      contains('الثلث الأخير من الليل'),
    );
    // After-prayer alerts (the quiet ones) are off by default.
    expect(notifications.scheduled.any((alert) => alert.quiet), isFalse);
  });

  testWidgets('switching a window off on the Windows tab re-plans the alerts', (
    tester,
  ) async {
    final cache = MemoryCache();
    await cache.write(CacheKey.onboardingDone, 'true');
    await cache.write(
      CacheKey.location,
      jsonEncode(
        const SavedLocation(latitude: 31.2001, longitude: 29.9187).toJson(),
      ),
    );
    final notifications = await pumpApp(tester, cache: cache);
    bool anyAdhkar() =>
        notifications.scheduled.any((alert) => alert.title.contains('أذكار'));
    expect(anyAdhkar(), isTrue);

    await tester.tap(find.text('النوافذ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('أذكار الصباح والمساء'));
    await tester.pumpAndSettle();

    expect(notifications.scheduled, isNotEmpty);
    expect(anyAdhkar(), isFalse);
  });

  test('ThemeController defaults to light, ignoring the OS setting', () {
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(MemoryCache())],
    );
    addTearDown(container.dispose);

    expect(container.read(themeControllerProvider), ThemeMode.light);
  });

  test('ThemeController restores and saves the chosen theme', () async {
    final cache = MemoryCache();
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
