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
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/custom_dua.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/controller/custom_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/controller/dua_catalog_controller.dart';
import 'package:ijaba/features/duas/presentation/pages/custom_dua_editor_page.dart';
import 'package:ijaba/features/duas/presentation/pages/library_page.dart';
import 'package:ijaba/features/duas/presentation/pages/my_duas_page.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// The user's own duas: stored on the phone, merged after the bundled ones,
/// and the Library → My duas → editor flow.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  ProviderContainer container(MemoryCache cache) {
    final container = ProviderContainer(
      overrides: [
        SimpleCache.provider.overrideWithValue(cache),
        bundledDuaCatalogProvider.overrideWith(
          (ref) async => testDuaCatalog(),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('CustomDuas', () {
    test('adds, edits and deletes, and keeps them on the phone', () async {
      final cache = MemoryCache();
      final c = container(cache);
      final duas = c.read(customDuasProvider.notifier);

      final id = await duas.add('  اللهم اشف أمي  ', const [
        DuaWindowType.fridayHour,
        DuaWindowType.lastThirdOfNight,
      ]);
      expect(c.read(customDuasProvider).single.text, 'اللهم اشف أمي');
      // In the windows' own order.
      expect(c.read(customDuasProvider).single.windows, const [
        DuaWindowType.lastThirdOfNight,
        DuaWindowType.fridayHour,
      ]);

      // A fresh start reads them back.
      final again = container(cache);
      expect(again.read(customDuasProvider).single.id, id);

      await duas.edit(id, text: 'اللهم اشف أبي', windows: const []);
      expect(c.read(customDuasProvider).single.text, 'اللهم اشف أبي');
      expect(c.read(customDuasProvider).single.windows, isEmpty);

      await duas.remove(id);
      expect(c.read(customDuasProvider), isEmpty);
      expect(cache.read(CacheKey.customDuas), '[]');
    });

    test('join their windows after the sourced duas, and My duas', () async {
      final c = container(MemoryCache());
      final id = await c
          .read(customDuasProvider.notifier)
          .add('اللهم اشف أمي', CustomDua.defaultWindows);
      final catalog = await c.read(duaCatalogProvider.future);

      final lastThird = catalog.forWindow(DuaWindowType.lastThirdOfNight);
      expect(lastThird.last.id, id);
      expect(lastThird.first.mine, isFalse);
      expect(
        catalog.forWindow(DuaWindowType.morningAdhkar).map((d) => d.id),
        isNot(contains(id)),
      );
      expect(
        LibraryCategory.mine.of(catalog, const {}).map((d) => d.id),
        [id],
      );
      expect(catalog.search('اشف امي').map((d) => d.id), [id]);
    });
  });

  group('My duas', () {
    Future<MemoryCache> pump(
      WidgetTester tester, {
      String location = AppRoutes.duas,
      String language = 'ar',
      Size size = const Size(390, 844),
      List<CustomDua> duas = const [],
    }) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final cache = MemoryCache();
      final scope = ProviderScope(
        overrides: [
          SimpleCache.provider.overrideWithValue(cache),
          NotificationService.provider.overrideWithValue(FakeNotifications()),
          bundledDuaCatalogProvider.overrideWith(
            (ref) async => testDuaCatalog(),
          ),
          routerProvider.overrideWithValue(
            GoRouter(initialLocation: location, routes: appRoutes),
          ),
        ],
        child: App(translations: TestTranslations()),
      );
      await tester.pumpWidget(scope);
      await tester.pump(const Duration(milliseconds: 300));
      final context = tester.element(find.byType(Scaffold).first);
      if (context.locale.languageCode != language) {
        await context.setLocale(Locale(language));
      }
      final container = ProviderScope.containerOf(context);
      for (final dua in duas) {
        await container
            .read(customDuasProvider.notifier)
            .add(dua.text, dua.windows);
      }
      await tester.pumpAndSettle();
      return cache;
    }

    const sample = [
      CustomDua(
        id: '1',
        text: 'اللهم اشف أمي شفاءً لا يغادر سقمًا، وارزقها الصحة والعافية',
        windows: CustomDua.defaultWindows,
      ),
      CustomDua(id: '2', text: 'O Allah, guide my children.'),
    ];

    const phones = {
      'small (360 × 640)': Size(360, 640),
      'design (390 × 844)': Size(390, 844),
    };
    for (final language in const ['ar', 'en']) {
      for (final MapEntry(key: phone, value: size) in phones.entries) {
        testWidgets('the list and editor ($language) fit a $phone phone', (
          tester,
        ) async {
          await pump(
            tester,
            location: AppRoutes.myDuas,
            language: language,
            size: size,
            duas: sample,
          );
          expect(find.byType(MyDuasPage), findsOneWidget);
          expect(tester.takeException(), isNull);

          await tester.tap(find.textContaining('اللهم اشف أمي'));
          await tester.pumpAndSettle();
          expect(find.byType(CustomDuaEditorPage), findsOneWidget);
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('write one from the Library, then delete it', (tester) async {
      final cache = await pump(tester);

      await tester.scrollUntilVisible(
        find.text('أدعيتي'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      // Empty, but it opens: that's where the first one is written.
      expect(find.text('اكتب دعاءك الأول'), findsOneWidget);
      await tester.tap(find.text('أدعيتي'));
      await tester.pumpAndSettle();
      expect(find.text('لم تكتب دعاءك الخاص بعد'), findsOneWidget);

      await tester.tap(find.text('أضف دعاءً'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(CustomDuaEditorPage),
          matching: find.byType(TextField),
        ),
        'اللهم اشف أمي',
      );
      await tester.pump();
      await tester.tap(find.text('حفظ'));
      await tester.pumpAndSettle();

      expect(find.byType(MyDuasPage), findsOneWidget);
      expect(find.text('اللهم اشف أمي'), findsOneWidget);
      expect(cache.read(CacheKey.customDuas), contains('اللهم اشف أمي'));
      expect(cache.read(CacheKey.customDuas), contains('lastThirdOfNight'));

      await tester.tap(find.text('اللهم اشف أمي'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('حذف الدعاء'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('حذف'));
      await tester.pumpAndSettle();

      expect(find.text('لم تكتب دعاءك الخاص بعد'), findsOneWidget);
      expect(cache.read(CacheKey.customDuas), '[]');
      // Back to the Library.
      await tester.tap(find.byTooltip('رجوع').first);
      await tester.pumpAndSettle();
      expect(find.byType(LibraryPage), findsOneWidget);
    });

    testWidgets('the Dua screen shows one as the user\'s, with edit', (
      tester,
    ) async {
      await pump(
        tester,
        location: AppRoutes.libraryCategory(LibraryCategory.mine.name),
        duas: sample.take(1).toList(),
      );

      expect(find.textContaining('اللهم اشف أمي'), findsOneWidget);
      expect(find.text('من أدعيتك'), findsOneWidget);
      expect(find.textContaining('[يُراجَع'), findsNothing);
      expect(find.bySemanticsLabel('تعديل الدعاء'), findsOneWidget);
      expect(find.bySemanticsLabel('حفظ الدعاء'), findsNothing);
    });
  });
}
