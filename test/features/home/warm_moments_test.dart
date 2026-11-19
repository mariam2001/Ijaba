import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/ordinal.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/completion.dart';
import 'package:ijaba/features/duas/presentation/controller/completion_log_controller.dart';
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/duas/presentation/pages/completion_page.dart';
import 'package:ijaba/features/etiquette/presentation/pages/etiquette_page.dart';
import 'package:ijaba/features/home/presentation/controller/home_greeting_controller.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';
import '../../helpers/synthetic_day.dart';

/// Figma ١٤–١٧: the greeting, the completion screen and its count, the
/// etiquette page.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  group('the greeting', () {
    // The synthetic day's prayers (UTC): Fajr 05:00, Dhuhr 12:00, Asr 15:00,
    // Maghrib 17:00, Isha 18:30. 24 Oct 2026 is a Saturday; the 23rd a
    // Friday.
    final saturday = syntheticDay(2026, 10, 24);
    final friday = syntheticDay(2026, 10, 23);
    HomeGreeting at(int hour, {bool fri = false, bool lastThird = false}) =>
        HomeGreeting.at(
          DateTime.utc(2026, 10, fri ? 23 : 24, hour),
          today: fri ? friday : saturday,
          lastThird: lastThird,
        );

    test('follows the day by its prayers', () {
      expect(at(7), HomeGreeting.afterFajr);
      expect(at(13), HomeGreeting.midday);
      expect(at(16), HomeGreeting.afterAsr);
      expect(at(20), HomeGreeting.afterMaghrib);
      expect(at(3), HomeGreeting.afterMaghrib); // Before Fajr: still night.
    });

    test('Friday from Fajr to Maghrib; the last third before all', () {
      expect(at(10, fri: true), HomeGreeting.friday);
      expect(at(16, fri: true), HomeGreeting.friday);
      expect(at(20, fri: true), HomeGreeting.afterMaghrib);
      expect(at(3, lastThird: true), HomeGreeting.lastThird);
    });
  });

  test('ordinals agree with the noun, in Arabic, and run past ten', () {
    expect(ordinal(4, 'ar', feminine: true), 'الرابعة');
    expect(ordinal(1, 'ar', feminine: true), 'الأولى');
    expect(ordinal(11, 'ar', feminine: true), 'الحادية عشرة');
    expect(ordinal(11, 'ar'), 'الحادي عشر');
    expect(ordinal(22, 'ar'), 'الثاني والعشرون');
    expect(ordinal(31, 'ar', feminine: true), 'الحادية والثلاثون');
    expect(ordinal(1, 'en'), '1st');
    expect(ordinal(12, 'en'), '12th');
    expect(ordinal(23, 'en'), '23rd');
  });

  test('completions count the days this month, once a day', () async {
    final cache = MemoryCache();
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);
    final log = container.read(completionLogProvider.notifier);

    expect(await log.record('window.x', DateTime(2026, 11, 3, 3)), 1);
    expect(await log.record('window.x', DateTime(2026, 11, 3, 4)), 1);
    expect(await log.record('window.x', DateTime(2026, 11, 9)), 2);
    expect(await log.record('window.y', DateTime(2026, 11, 9)), 1);
    // A new month starts again.
    expect(await log.record('window.x', DateTime(2026, 12)), 1);
    expect(cache.read(CacheKey.completions), contains('2026-12-01'));
  });

  test('what was finished, and how it is counted', () {
    final night = Completion.of(
      const WindowDuas(DuaWindowType.lastThirdOfNight),
      7,
    )!;
    expect(night.key, 'window.lastThirdOfNight');
    expect(night.adhkar, isFalse);
    expect(
      Completion.of(const CategoryDuas(LibraryCategory.morning), 15)!.adhkar,
      isTrue,
    );
    expect(Completion.of(const OneDua('afw'), 1), isNull);
  });

  group('screens', () {
    Future<void> pump(
      WidgetTester tester,
      String location, {
      required String language,
      required Size size,
      Object? extra,
    }) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            SimpleCache.provider.overrideWithValue(MemoryCache()),
            NotificationService.provider.overrideWithValue(FakeNotifications()),
            routerProvider.overrideWithValue(
              GoRouter(
                initialLocation: location,
                initialExtra: extra,
                routes: appRoutes,
              ),
            ),
          ],
          child: App(translations: TestTranslations()),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));
      final context = tester.element(find.byType(Scaffold).first);
      if (context.locale.languageCode != language) {
        await context.setLocale(Locale(language));
      }
      await tester.pumpAndSettle();
    }

    const phones = {
      'small (360 × 640)': Size(360, 640),
      'design (390 × 844)': Size(390, 844),
    };
    for (final language in const ['ar', 'en']) {
      for (final MapEntry(key: phone, value: size) in phones.entries) {
        testWidgets('the etiquette page ($language) fits a $phone phone', (
          tester,
        ) async {
          await pump(
            tester,
            AppRoutes.etiquette,
            language: language,
            size: size,
          );
          expect(find.byType(EtiquettePage), findsOneWidget);
          expect(tester.takeException(), isNull);
          await tester.drag(find.byType(ListView), const Offset(0, -3000));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        });

        testWidgets('the completion screen ($language) fits a $phone phone', (
          tester,
        ) async {
          await pump(
            tester,
            AppRoutes.completion,
            language: language,
            size: size,
            extra: (
              completion: Completion.of(
                const WindowDuas(DuaWindowType.lastThirdOfNight),
                7,
              )!,
              nth: 4,
            ),
          );
          expect(find.byType(CompletionPage), findsOneWidget);
          if (language == 'ar') {
            expect(find.text('ليلتك الرابعة هذا الشهر'), findsOneWidget);
          }
          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
