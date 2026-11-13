import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/pages/dua_page.dart';
import 'package:ijaba/features/duas/presentation/pages/library_page.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_search_result.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_view.dart';
import 'package:ijaba/features/duas/presentation/widgets/library_category_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// The Duas tab (Library) with the real bundled duas.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  Future<void> pumpLibrary(
    WidgetTester tester, {
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
          SimpleCache.provider.overrideWithValue(MemoryCache()),
          NotificationService.provider.overrideWithValue(FakeNotifications()),
          duaCatalogProvider.overrideWith((ref) async => testDuaCatalog()),
          routerProvider.overrideWithValue(
            GoRouter(initialLocation: AppRoutes.duas, routes: appRoutes),
          ),
        ],
        child: App(translations: TestTranslations()),
      ),
    );
    // Translations load first.
    await tester.pump(const Duration(milliseconds: 300));
    // The chosen language is remembered across tests, so always set it.
    final context = tester.element(find.byType(LibraryPage));
    if (context.locale.languageCode != language) {
      await context.setLocale(Locale(language));
    }
    await tester.pumpAndSettle();
  }

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: phone, value: size) in phones.entries) {
      testWidgets('Library ($language) fits a $phone phone', (tester) async {
        await pumpLibrary(tester, size: size, language: language);

        expect(find.byType(LibraryCategoryCard), findsNWidgets(5));
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('a shelf opens its duas in the Dua screen', (tester) async {
    await pumpLibrary(tester);

    await tester.tap(find.text('أذكار الصباح'));
    await tester.pumpAndSettle();

    expect(find.byType(DuaPage), findsOneWidget);
    expect(find.text('أذكار الصباح'), findsOneWidget);
  });

  testWidgets('nothing saved yet: the saved shelf says so and stays shut', (
    tester,
  ) async {
    await pumpLibrary(tester);

    expect(find.text('لا شيء محفوظ بعد'), findsOneWidget);
    await tester.tap(find.text('المحفوظة'));
    await tester.pumpAndSettle();
    expect(find.byType(DuaPage), findsNothing);
  });

  testWidgets('search lists matches; one opens on its own', (tester) async {
    await pumpLibrary(tester, language: 'en');

    await tester.enterText(find.byType(TextField), 'pardon me');
    await tester.pumpAndSettle();
    expect(find.byType(LibraryCategoryCard), findsNothing);
    expect(find.byType(DuaSearchResult), findsWidgets);

    await tester.tap(find.byType(DuaSearchResult).first);
    await tester.pumpAndSettle();
    expect(tester.widget<DuaView>(find.byType(DuaView)).dua.id, 'afw');
    expect(find.textContaining('1 of 1'), findsOneWidget);
  });

  testWidgets('a search with no matches says so', (tester) async {
    await pumpLibrary(tester);

    await tester.enterText(find.byType(TextField), 'qqqq');
    await tester.pumpAndSettle();
    expect(find.text('لا نتائج'), findsOneWidget);
  });
}
