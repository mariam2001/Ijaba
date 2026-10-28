import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/pages/dua_page.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:ijaba/features/home/presentation/widgets/window_row.dart';
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
          clockProvider.overrideWith((ref) => Stream.value(designNow)),
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

    expect(find.text('مفتوحة الآن'), findsOneWidget);
    // In the hero card and as the first row.
    expect(find.text('الثلث الأخير من الليل'), findsNWidgets(2));
    expect(find.text('١:١٨'), findsOneWidget);
    expect(find.text('الفجر · تنبيه قبل ٥ دقائق'), findsOneWidget);
    expect(find.text('الفجر · صامت'), findsOneWidget);
    expect(find.byType(WindowRow), findsNWidgets(4));
  });

  testWidgets('in English', (tester) async {
    await pumpHome(tester, language: 'en');

    expect(find.text('OPEN NOW'), findsOneWidget);
    expect(find.text('1:18'), findsOneWidget);
    expect(find.text('2:04 — 4:30 AM'), findsOneWidget);
    expect(find.text('Fajr · 5 min before'), findsOneWidget);
    expect(find.text('Friday, 18 Rabi al-Akhir'), findsOneWidget);
  });

  testWidgets('before a window opens, counts down to it', (tester) async {
    final next = designTodayWindows().windows[1]; // Fajr adhan at 04:30
    await pumpHome(
      tester,
      language: 'en',
      today: TodayWindows(windows: [next], featured: next),
    );

    expect(find.text('UP NEXT'), findsOneWidget);
    expect(find.text('starts in'), findsOneWidget);
    expect(find.text('1:18'), findsOneWidget);
  });

  testWidgets('"Make dua now" opens the duas of the featured window', (
    tester,
  ) async {
    await pumpHome(tester);

    await tester.tap(find.text('ادعُ الآن'));
    await tester.pumpAndSettle();

    expect(find.byType(DuaPage), findsOneWidget);
    expect(find.text('الثلث الأخير من الليل'), findsOneWidget);
  });

  testWidgets('says so when no windows are left', (tester) async {
    await pumpHome(tester, today: const TodayWindows(windows: []));

    expect(find.text('لا نوافذ أخرى اليوم'), findsOneWidget);
    expect(find.byType(WindowRow), findsNothing);
  });
}
