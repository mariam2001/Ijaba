// Renders the Play Store assets from the real app, to build/store_assets/:
// phone screenshots in Arabic and English at 1080 × 1920 (9:16, as Play
// wants for promotion), and the 1024 × 500 feature graphic, which is the
// splash's composition (mark, name, branch, verse) laid out wide. Not part
// of the normal test run:
//
//   flutter test tool/store_assets/store_assets_test.dart
//
// Play takes PNGs without transparency: flatten them before uploading.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';
import 'package:ijaba/core/components/branch_ornament.dart';
import 'package:ijaba/core/components/ijaba_mark.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/completion.dart';
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/onboarding/data/datasource/device_power_settings.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../test/helpers/fakes.dart';

/// 1080 × 1920 pixels: a 432 × 768 phone at 2.5x.
const _pixelRatio = 2.5;
const _screen = Size(1080, 1920);

Future<void> _loadFonts() async {
  Future<void> family(String name, List<String> assets) async {
    final loader = FontLoader(name);
    for (final asset in assets) {
      loader.addFont(rootBundle.load(asset));
    }
    await loader.load();
  }

  await family('ReadexPro', [
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold', 'Bold'])
      'assets/fonts/ReadexPro-$weight.ttf',
  ]);
  await family('Amiri', [
    'assets/fonts/Amiri-Regular.ttf',
    'assets/fonts/Amiri-Bold.ttf',
  ]);
  await family('packages/lucide_icons_flutter/Lucide300', [
    'packages/lucide_icons_flutter/assets/build_font/LucideVariable-w300.ttf',
  ]);
}

Future<void> _save(GlobalKey boundary, String name, double ratio) async {
  final render =
      boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await render.toImage(pixelRatio: ratio);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  File('build/store_assets/$name.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(png!.buffer.asUint8List());
}

void main() {
  setUpAll(() async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
    await _loadFonts();
  });

  // The screens, in the order Play shows them. Home is the design's moment
  // (Friday 03:12, the last third open, four days done this week); the Dua
  // screen is by night, as the design draws it.
  final screens = <String, ({String path, bool night})>{
    '1_home': (path: AppRoutes.home, night: false),
    '2_dua': (
      path: AppRoutes.duaFor(DuaWindowType.lastThirdOfNight.name),
      night: true,
    ),
    '3_windows': (path: AppRoutes.windows, night: false),
    '4_library': (path: AppRoutes.duas, night: false),
    '5_completion': (path: AppRoutes.completion, night: false),
    '6_etiquette': (path: AppRoutes.etiquette, night: false),
  };

  for (final language in const ['ar', 'en']) {
    for (final MapEntry(key: name, value: (:path, :night)) in screens.entries) {
      testWidgets('screenshot $language/$name', (tester) async {
        final cache = MemoryCache();
        await cache.write(
          CacheKey.duaDays,
          '["2028-09-02","2028-09-03","2028-09-05","2028-09-06"]',
        );
        if (night) await cache.write(CacheKey.themeMode, 'dark');

        tester.view
          ..physicalSize = _screen
          ..devicePixelRatio = _pixelRatio
          ..padding = FakeViewPadding.zero;
        addTearDown(tester.view.reset);

        final boundary = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: boundary,
            child: ProviderScope(
              overrides: [
                SimpleCache.provider.overrideWithValue(cache),
                NotificationService.provider.overrideWithValue(
                  FakeNotifications(),
                ),
                DevicePowerSettings.provider.overrideWithValue(
                  FakeOppoPhone(),
                ),
                clockProvider.overrideWith((ref) => Stream.value(designNow)),
                // The real duas.
                bundledDuaCatalogProvider.overrideWith(
                  (ref) async => testDuaCatalog(),
                ),
                todayWindowsProvider.overrideWith(
                  (ref) async => designTodayWindows(),
                ),
                routerProvider.overrideWithValue(
                  GoRouter(
                    initialLocation: path,
                    initialExtra: path == AppRoutes.completion
                        ? (
                            completion: Completion.of(
                              const WindowDuas(DuaWindowType.lastThirdOfNight),
                              7,
                            )!,
                            nth: 4,
                          )
                        : null,
                    routes: appRoutes,
                  ),
                ),
              ],
              child: App(translations: TestTranslations()),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        final context = tester.element(find.byType(Scaffold).first);
        if (context.locale.languageCode != language) {
          await context.setLocale(Locale(language));
        }
        for (var i = 0; i < 3; i++) {
          await tester.pump(const Duration(milliseconds: 300));
        }
        await tester.pump(const Duration(seconds: 1));

        await tester.runAsync(
          () => _save(boundary, '$language/$name', _pixelRatio),
        );
      });
    }
  }

  testWidgets('feature graphic', (tester) async {
    tester.view
      ..physicalSize = const Size(1024, 500)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    const colors = AppColors.day;
    final boundary = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: ScreenUtilInit(
          // 1 design px = 1 px, so the mark's strokes keep Figma's weight.
          designSize: const Size(1024, 500),
          builder: (context, _) => Directionality(
            textDirection: TextDirection.rtl,
            child: ColoredBox(
              color: colors.green,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IjabaMark(width: 82, color: colors.paper),
                    const SizedBox(height: 22),
                    Text(
                      'إجابة',
                      style: TextStyle(
                        fontFamily: AppFonts.amiri,
                        fontWeight: FontWeight.w700,
                        fontSize: 58,
                        height: 1.25,
                        color: colors.paper,
                      ),
                    ),
                    Text(
                      'IJABA',
                      style: TextStyle(
                        fontFamily: AppFonts.readexPro,
                        fontSize: 15,
                        letterSpacing: 4.8,
                        color: colors.greenPale,
                      ),
                    ),
                    const SizedBox(height: 22),
                    BranchOrnament(
                      width: 180,
                      color: colors.greenPale.withValues(alpha: 0.45),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ',
                      style: TextStyle(
                        fontFamily: AppFonts.amiri,
                        fontSize: 24,
                        color: colors.greenPale,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.runAsync(() => _save(boundary, 'feature_graphic', 1));
  });
}
