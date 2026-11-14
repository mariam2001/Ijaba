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
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/settings/presentation/pages/settings_page.dart';
import 'package:ijaba/features/settings/presentation/widgets/adjustment_sheet.dart';
import 'package:ijaba/features/settings/presentation/widgets/settings_section.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  Future<MemoryCache> pumpSettings(
    WidgetTester tester, {
    Size size = const Size(390, 844),
    String language = 'ar',
  }) async {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final cache = MemoryCache();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          SimpleCache.provider.overrideWithValue(cache),
          NotificationService.provider.overrideWithValue(FakeNotifications()),
          routerProvider.overrideWithValue(
            GoRouter(initialLocation: AppRoutes.settings, routes: appRoutes),
          ),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    // Translations load first.
    await tester.pump(const Duration(milliseconds: 300));
    // The chosen language is remembered across tests, so always set it.
    final context = tester.element(find.byType(SettingsPage));
    if (context.locale.languageCode != language) {
      await context.setLocale(Locale(language));
    }
    await tester.pumpAndSettle();
    return cache;
  }

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: phone, value: size) in phones.entries) {
      testWidgets('Settings ($language) fits a $phone phone', (tester) async {
        await pumpSettings(tester, size: size, language: language);
        expect(find.byType(SettingsRow), findsWidgets);
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);

        // The list builds lazily: scroll to the last row to lay it out too.
        await tester.drag(find.byType(ListView), const Offset(0, -2000));
        await tester.pumpAndSettle();
        expect(
          find.text(language == 'ar' ? 'عن إجابة' : 'About Ijaba'),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('shows the defaults', (tester) async {
    await pumpSettings(tester);

    expect(find.text('الهيئة المصرية العامة للمساحة'), findsOneWidget);
    expect(find.text('الشافعي'), findsOneWidget);
    expect(find.text('±٠ دقيقة'), findsOneWidget);
    expect(find.text('العربية'), findsOneWidget);
  });

  testWidgets('picking a calculation method saves it', (tester) async {
    final cache = await pumpSettings(tester);

    await tester.tap(find.text('طريقة الحساب'));
    await tester.pumpAndSettle();
    // The sheet lists every method; scroll to it first.
    await tester.ensureVisible(find.text('رابطة العالم الإسلامي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('رابطة العالم الإسلامي'));
    await tester.pumpAndSettle();

    expect(find.text('رابطة العالم الإسلامي'), findsOneWidget);
    expect(cache.read(CacheKey.prayerSettings), contains('muslimWorldLeague'));
  });

  testWidgets('a prayer\'s adjustment shows in the row', (tester) async {
    await pumpSettings(tester, language: 'en');

    await tester.tap(find.text('Adjust adhan times'));
    await tester.pumpAndSettle();
    // The first "+" is Fajr's.
    await tester.tap(find.byTooltip('+').first);
    await tester.tap(find.byTooltip('+').first);
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(195, 40)); // Close the sheet.
    await tester.pumpAndSettle();

    // "+2", kept left-to-right by invisible isolate marks.
    expect(find.text('Fajr ${signedMinutes(2, 'en')}'), findsOneWidget);
  });

  testWidgets('iqama timings: a change shows as custom, and resets', (
    tester,
  ) async {
    final cache = await pumpSettings(tester, language: 'en');
    expect(find.text('Default'), findsOneWidget);

    await tester.tap(find.text('Iqama & prayer'));
    await tester.pumpAndSettle();
    // The first "+" is Fajr's iqama: 20 → 21 minutes.
    await tester.tap(find.byTooltip('+').first);
    await tester.pumpAndSettle();
    expect(find.text('21'), findsOneWidget);
    expect(cache.read(CacheKey.windowConfig), contains('"fajr":21'));

    await tester.tap(find.text('Reset to default'));
    await tester.pumpAndSettle();
    expect(find.text('21'), findsNothing);
    await tester.tapAt(const Offset(195, 40)); // Close the sheet.
    await tester.pumpAndSettle();
    expect(find.text('Default'), findsOneWidget);
  });

  testWidgets('switching the language to English', (tester) async {
    await pumpSettings(tester);

    await tester.tap(find.text('اللغة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // The title and the tab.
    expect(find.text('Settings'), findsNWidgets(2));
    expect(find.text('Calculation method'), findsOneWidget);
  });

  testWidgets('night mode: picking "always dark" saves it and turns night', (
    tester,
  ) async {
    final cache = await pumpSettings(tester);
    expect(find.text('حسب الهاتف'), findsOneWidget);

    await tester.tap(find.text('وضع الليل'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ليلي دائمًا'));
    await tester.pumpAndSettle();

    expect(cache.read(CacheKey.themeMode), 'dark');
    expect(find.text('ليلي دائمًا'), findsOneWidget);
    final theme = Theme.of(tester.element(find.byType(SettingsPage)));
    expect(theme.brightness, Brightness.dark);
  });
}
