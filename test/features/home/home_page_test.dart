import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/components/card_dots.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/presentation/controller/dua_catalog_controller.dart';
import 'package:ijaba/features/duas/presentation/pages/dua_page.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:ijaba/features/home/presentation/widgets/window_hero_card.dart';
import 'package:ijaba/features/home/presentation/widgets/window_row.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/data/model/today_windows.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// Home in the state the Figma frames show, in both languages, from a small
/// phone to a large one.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  Future<void> pumpHome(
    WidgetTester tester, {
    Size size = const Size(390, 844),
    String language = 'ar',
    TodayWindows? today,
    DateTime? now,
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
          clockProvider.overrideWith((ref) => Stream.value(now ?? designNow)),
          duaCatalogProvider.overrideWith((ref) async => designDuaCatalog()),
          todayWindowsProvider.overrideWith(
            (ref) async => today ?? designTodayWindows(),
          ),
          routerProvider.overrideWithValue(
            GoRouter(initialLocation: AppRoutes.home, routes: appRoutes),
          ),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    // Translations load first.
    await tester.pump(const Duration(milliseconds: 300));
    // The chosen language is remembered across tests, so always set it.
    final context = tester.element(find.byType(HomePage));
    if (context.locale.languageCode != language) {
      await context.setLocale(Locale(language));
    }
    // Clock and windows arrive asynchronously, then rebuild.
    await tester.pump();
    await tester.pump();
  }

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: phone, value: size) in phones.entries) {
      testWidgets('Home ($language) fits a $phone phone', (tester) async {
        await pumpHome(tester, size: size, language: language);

        expect(find.byType(HomePage), findsOneWidget);
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('shows the open window, its time left, and the day', (
    tester,
  ) async {
    await pumpHome(tester);

    // The warm Home's greeting at 03:12, in the last third.
    expect(find.text('ليلتك مباركة'), findsOneWidget);
    expect(find.text('مفتوحة الآن'), findsOneWidget);
    expect(find.text('١:١٨'), findsOneWidget);

    // Below the reminder, the hero and the etiquette card: the day's rows.
    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pumpAndSettle();
    // In the hero card and as the first row.
    expect(find.text('الثلث الأخير من الليل'), findsWidgets);
    expect(find.text('الفجر · تنبيه قبل ٥ دقائق'), findsOneWidget);
    expect(find.text('الفجر · صامت'), findsOneWidget);
    expect(find.byType(WindowRow), findsWidgets);
  });

  testWidgets('in English', (tester) async {
    await pumpHome(tester, language: 'en');

    expect(find.text('A blessed night to you'), findsOneWidget);
    expect(find.text('Friday, September 8'), findsOneWidget);
    expect(find.text('OPEN NOW'), findsOneWidget);
    expect(find.text('1:18'), findsOneWidget);
    expect(find.text('2:04 — 4:30 AM'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pumpAndSettle();
    expect(find.text('Fajr · 5 min before'), findsOneWidget);
  });

  testWidgets('before a window opens, counts down to it', (tester) async {
    final next = designTodayWindows().windows[1]; // Fajr adhan at 04:30
    await pumpHome(
      tester,
      language: 'en',
      today: TodayWindows(windows: [next], hero: [next]),
    );

    expect(find.text('UP NEXT'), findsOneWidget);
    expect(find.text('starts in'), findsOneWidget);
    expect(find.text('1:18'), findsOneWidget);
  });

  testWidgets('"Make dua now" opens the duas of the featured window', (
    tester,
  ) async {
    await pumpHome(tester);

    await tester.ensureVisible(find.text('ادعُ الآن'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ادعُ الآن'));
    await tester.pumpAndSettle();

    expect(find.byType(DuaPage), findsOneWidget);
    expect(find.text('الثلث الأخير من الليل'), findsOneWidget);
  });

  testWidgets('several windows open at once: swipe between them', (
    tester,
  ) async {
    // That Friday at 17:30: evening adhkar and the Friday hour are open.
    DateTime at(int hour, int minute) =>
        DateTime(2028, 9, 8, hour, minute).toUtc();
    final friday = DuaWindow(
      type: DuaWindowType.fridayHour,
      start: at(17, 6),
      end: at(18, 6),
    );
    final evening = DuaWindow(
      type: DuaWindowType.eveningAdhkar,
      start: at(15, 30),
      end: at(18, 6),
    );
    await pumpHome(
      tester,
      now: DateTime(2028, 9, 8, 17, 30),
      today: TodayWindows(windows: [evening, friday], hero: [friday, evening]),
    );
    await tester.pumpAndSettle();
    final hero = find.byType(WindowHeroCard);
    Finder inHero(Finder finder) => find.descendant(of: hero, matching: finder);

    expect(inHero(find.text('ساعة الإجابة')), findsOneWidget);
    expect(inHero(find.byType(CardDots)), findsOneWidget);

    // In Arabic the next one comes from the left: swipe to the right.
    await tester.ensureVisible(hero);
    await tester.fling(hero, const Offset(250, 0), 1000);
    await tester.pumpAndSettle();
    expect(inHero(find.text('أذكار المساء')), findsOneWidget);
    expect(inHero(find.text('ساعة الإجابة')), findsNothing);

    await tester.tap(inHero(find.text('ادعُ الآن')));
    await tester.pumpAndSettle();
    expect(find.byType(DuaPage), findsOneWidget);
    expect(find.text('أذكار المساء'), findsOneWidget);
  });

  testWidgets('one window: no dots, nothing to swipe', (tester) async {
    await pumpHome(tester);
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(WindowHeroCard),
        matching: find.byType(CardDots),
      ),
      findsNothing,
    );
  });

  testWidgets("a row opens its window's duas", (tester) async {
    await pumpHome(tester);
    await tester.pumpAndSettle();

    // Fajr's adhan to iqama, below the cards.
    await tester.drag(find.byType(ListView), const Offset(0, -2000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الفجر · تنبيه قبل ٥ دقائق'));
    await tester.pumpAndSettle();

    expect(find.byType(DuaPage), findsOneWidget);
    expect(find.text('بين الأذان والإقامة'), findsOneWidget);
  });

  testWidgets('says so when no windows are left', (tester) async {
    await pumpHome(tester, today: const TodayWindows(windows: []));

    expect(find.text('لا نوافذ أخرى اليوم'), findsOneWidget);
    expect(find.byType(WindowRow), findsNothing);
  });
}
