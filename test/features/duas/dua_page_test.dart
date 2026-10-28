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
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/pages/dua_page.dart';
import 'package:ijaba/features/duas/presentation/widgets/tasbih_counter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// The Dua screen with the design's sequence: seven duas for the last third,
/// the real one second.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  Future<void> pumpDua(
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
          clockProvider.overrideWith((ref) => Stream.value(designNow)),
          duaCatalogProvider.overrideWith((ref) async => designDuaCatalog()),
          routerProvider.overrideWithValue(
            GoRouter(
              initialLocation: AppRoutes.duaFor('lastThirdOfNight'),
              routes: appRoutes,
            ),
          ),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    // Translations load first.
    await tester.pump(const Duration(milliseconds: 300));
    // The chosen language is remembered across tests, so always set it.
    final context = tester.element(find.byType(DuaPage));
    if (context.locale.languageCode != language) {
      await context.setLocale(Locale(language));
    }
    await tester.pump();
    await tester.pump();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  Future<void> count(WidgetTester tester, int times) async {
    for (var i = 0; i < times; i++) {
      await tester.tap(find.byType(TasbihCounter).first);
      await tester.pump();
    }
  }

  ButtonStyleButton button(WidgetTester tester, String label) =>
      tester.widget<ButtonStyleButton>(
        find.ancestor(
          of: find.text(label),
          matching: find.bySubtype<ButtonStyleButton>(),
        ),
      );

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: phone, value: size) in phones.entries) {
      testWidgets('Dua ($language) fits a $phone phone', (tester) async {
        await pumpDua(tester, size: size, language: language);
        await tapText(tester, language == 'ar' ? 'التالي' : 'Next');

        expect(find.textContaining('عَفُوٌّ'), findsOneWidget);
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('steps through the window\'s duas', (tester) async {
    await pumpDua(tester);

    expect(find.text('الثلث الأخير من الليل'), findsOneWidget);
    expect(find.textContaining('١ من ٧'), findsOneWidget);
    expect(button(tester, 'السابق').enabled, isFalse);

    await tapText(tester, 'التالي');
    expect(find.textContaining('٢ من ٧'), findsOneWidget);
    expect(find.text('اللهم إنك عفوٌّ كريم، تحب العفو، فاعف عني.'), findsOne);
    // Unverified, so the source is flagged.
    expect(find.textContaining('[يُراجَع التخريج قبل النشر]'), findsOneWidget);

    for (var i = 0; i < 5; i++) {
      await tapText(tester, 'التالي');
    }
    expect(find.textContaining('٧ من ٧'), findsOneWidget);
    expect(button(tester, 'التالي').enabled, isFalse);
  });

  testWidgets('English adds the transliteration', (tester) async {
    await pumpDua(tester, language: 'en');
    await tapText(tester, 'Next');

    expect(
      find.text("Allahumma innaka afuwwun tuhibbul afwa fa'fu anni"),
      findsOneWidget,
    );
    expect(find.textContaining('2 of 7'), findsOneWidget);
    expect(
      find.textContaining('[verify attribution before release]'),
      findsOneWidget,
    );
  });

  testWidgets('counts up to the target, and remembers it per dua', (
    tester,
  ) async {
    await pumpDua(tester, language: 'en');
    await tapText(tester, 'Next');

    expect(find.text('of 3'), findsOneWidget);
    await count(tester, 4);
    // Stops at 3.
    expect(find.text('3'), findsOneWidget);

    await tapText(tester, 'Next');
    expect(find.text('0'), findsOneWidget);
    await tapText(tester, 'Previous');
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('the bookmark saves the dua', (tester) async {
    final cache = MemoryCache();
    await pumpDua(tester, cache: cache, language: 'en');
    await tapText(tester, 'Next');

    await tester.tap(find.bySemanticsLabel('Save dua'));
    await tester.pump();
    expect(cache.read(CacheKey.savedDuas), '["afw"]');
    expect(find.bySemanticsLabel('Remove from saved'), findsOneWidget);
  });
}
