import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/components/app_switch.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/windows/presentation/pages/windows_page.dart';
import 'package:ijaba/features/windows/presentation/widgets/alert_toggle_row.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// The Windows (alert control) screen, in both languages, from a small phone
/// to a large one.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  Future<void> pumpWindows(
    WidgetTester tester, {
    MemoryCache? cache,
    Size size = const Size(390, 844),
    String language = 'ar',
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
            GoRouter(initialLocation: AppRoutes.windows, routes: appRoutes),
          ),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    // Translations load first.
    await tester.pump(const Duration(milliseconds: 300));
    // The chosen language is remembered across tests, so always set it.
    final context = tester.element(find.byType(WindowsPage));
    if (context.locale.languageCode != language) {
      await context.setLocale(Locale(language));
    }
    await tester.pump();
  }

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: phone, value: size) in phones.entries) {
      testWidgets('Windows ($language) fits a $phone phone', (tester) async {
        await pumpWindows(tester, size: size, language: language);

        expect(find.byType(AlertToggleRow), findsNWidgets(5));
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('starts with everything on except after-prayer', (tester) async {
    await pumpWindows(tester, language: 'en');

    expect(find.text('4 of 5 alerts on'), findsOneWidget);
    expect(find.text('4 / 5'), findsOneWidget);
    expect(find.text('Silent — no alert'), findsOneWidget);
    expect(
      tester.widgetList<AppSwitch>(find.byType(AppSwitch)).map((s) => s.value),
      [true, true, false, true, true],
    );
  });

  testWidgets('tapping a row flips its switch, the count and the cache', (
    tester,
  ) async {
    final cache = MemoryCache();
    await pumpWindows(tester, cache: cache);

    await tester.tap(find.text('دبر الصلوات المكتوبة'));
    await tester.pumpAndSettle();
    expect(find.text('٥ / ٥'), findsOneWidget);
    expect(find.text('تنبيه هادئ بلا صوت'), findsOneWidget);

    await tester.tap(find.text('أذكار الصباح والمساء'));
    await tester.pumpAndSettle();
    expect(find.text('٤ / ٥'), findsOneWidget);
    expect(cache.read(CacheKey.enabledWindows), isNot(contains('Adhkar')));
  });
}
