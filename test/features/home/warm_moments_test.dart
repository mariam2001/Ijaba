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
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/duas/presentation/pages/completion_page.dart';
import 'package:ijaba/features/etiquette/presentation/pages/etiquette_page.dart';
import 'package:ijaba/features/home/presentation/controller/home_greeting_controller.dart';
import 'package:ijaba/features/progress/data/model/dua_week.dart';
import 'package:ijaba/features/progress/presentation/controller/dua_days_controller.dart';
import 'package:ijaba/features/progress/presentation/widgets/days_card.dart';
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

  test('days are kept once each, and the week counts from Saturday', () async {
    final cache = MemoryCache();
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);
    final days = container.read(duaDaysProvider.notifier);

    // Thursday 19 Nov 2026: the week began on Saturday the 14th.
    expect(await days.record(DateTime(2026, 11, 14, 22)), 1);
    expect(await days.record(DateTime(2026, 11, 16, 3)), 2);
    expect(await days.record(DateTime(2026, 11, 16, 4)), 2); // Same day.
    expect(await days.record(DateTime(2026, 11, 19, 3)), 3);
    // Saturday the 21st starts a new week; the total keeps every day.
    expect(await days.record(DateTime(2026, 11, 21)), 1);
    expect(container.read(duaDaysProvider), hasLength(4));
    expect(cache.read(CacheKey.duaDays), contains('2026-11-21'));
  });

  test("the first version's per-window dates are folded in", () {
    final cache = MemoryCache()
      ..write(
        CacheKey.completions,
        '{"window.lastThirdOfNight":["2026-11-18","2026-11-19"],'
        '"shelf.morning":["2026-11-19"]}',
      );
    final container = ProviderContainer(
      overrides: [SimpleCache.provider.overrideWithValue(cache)],
    );
    addTearDown(container.dispose);

    expect(container.read(duaDaysProvider), {
      DateTime(2026, 11, 18),
      DateTime(2026, 11, 19),
    });
  });

  group('the week', () {
    final thursday = DateTime(2026, 11, 19, 9); // Week of Sat 14 Nov.
    Set<DateTime> days(List<int> dates) => {
      for (final d in dates) DateTime(2026, 11, d),
    };

    test('marks done, missed, today and the days to come', () {
      final week = DuaWeek(thursday, days([14, 15, 17, 18]));
      expect(week.marks, [
        DayMark.done, // Sat
        DayMark.done, // Sun
        DayMark.missed, // Mon
        DayMark.done, // Tue
        DayMark.done, // Wed
        DayMark.today, // Thu
        DayMark.future, // Fri
      ]);
      expect(week.done, 4);
      expect(week.line, WeekLine.midWeek);
    });

    test('a full week; a new one on Saturday', () {
      final friday = DateTime(2026, 11, 20, 20);
      final full = DuaWeek(friday, days([14, 15, 16, 17, 18, 19, 20]));
      expect(full.done, 7);
      expect(full.marks.last, DayMark.todayDone);
      expect(full.line, WeekLine.full);

      final saturday = DuaWeek(
        DateTime(2026, 11, 21, 8),
        days([14, 15, 16, 17, 18, 19, 20]),
      );
      expect(saturday.done, 0);
      expect(saturday.marks.first, DayMark.today);
      expect(saturday.line, WeekLine.saturday);
    });
  });

  test('what was finished, and how it is counted', () {
    final night = Completion.of(
      const WindowDuas(DuaWindowType.lastThirdOfNight),
      7,
    )!;
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
      MemoryCache? cache,
    }) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            SimpleCache.provider.overrideWithValue(cache ?? MemoryCache()),
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

    testWidgets('Settings counts the days, once there is one', (
      tester,
    ) async {
      await pump(
        tester,
        AppRoutes.settings,
        language: 'ar',
        size: const Size(390, 844),
      );
      expect(find.byType(DaysCard), findsNothing);

      final cache = MemoryCache();
      await cache.write(
        CacheKey.duaDays,
        '["2026-10-02","2026-10-03","2026-11-19"]',
      );
      await pump(
        tester,
        AppRoutes.settings,
        language: 'ar',
        size: const Size(390, 844),
        cache: cache,
      );
      await tester.scrollUntilVisible(
        find.byType(DaysCard),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('٣'), findsOneWidget);
      expect(find.text('أيام من الدعاء'), findsOneWidget);
      expect(find.text('منذ ٢ أكتوبر ٢٠٢٦'), findsOneWidget);
      expect(find.text('بينك وبين الله — لا يراه أحد غيرك 🤍'), findsOneWidget);
    });

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
            expect(find.text('يومك الرابع هذا الأسبوع'), findsOneWidget);
          }
          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
