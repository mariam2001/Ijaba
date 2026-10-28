// Renders app screens at the Figma frame size (390 × 844, 1x) with the real
// fonts, to build/design_check/<name>.png, for side-by-side comparison with
// the design exports. Not part of the normal test run:
//
//   flutter test tool/design_check/design_check_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/app.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/routes.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/features/location/data/datasource/location_service.dart';
import 'package:ijaba/features/onboarding/data/datasource/device_power_settings.dart';
import 'package:ijaba/features/onboarding/presentation/pages/splash_page.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../test/helpers/fakes.dart';

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
  final icons = File(
    '${Platform.environment['FLUTTER_ROOT']}/bin/cache/artifacts/'
    'material_fonts/MaterialIcons-Regular.otf',
  );
  final iconLoader = FontLoader('MaterialIcons')
    ..addFont(Future.value(ByteData.sublistView(icons.readAsBytesSync())));
  await iconLoader.load();
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

  // The states the Figma frames show: Oppo phone, steps 1–2 granted, GPS
  // already allowed and in Alexandria; Home on Friday at 03:12.
  const screens = {
    '1_splash': (AppRoutes.splash, 'ar'),
    '2_language': (AppRoutes.language, 'ar'),
    '3_welcome': (AppRoutes.welcome, 'ar'),
    '4_location': (AppRoutes.location, 'ar'),
    '5_permissions': (AppRoutes.permissions, 'ar'),
    '6_home': (AppRoutes.home, 'ar'),
    '11_home_en': (AppRoutes.home, 'en'),
    '7_windows': (AppRoutes.windows, 'ar'),
    '12_windows_en': (AppRoutes.windows, 'en'),
  };

  for (final MapEntry(key: name, value: (path, language)) in screens.entries) {
    testWidgets('render $name', (tester) async {
      tester.view
        ..physicalSize = const Size(390, 844)
        ..devicePixelRatio = 1
        ..padding = FakeViewPadding.zero;
      addTearDown(tester.view.reset);

      final boundary = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: boundary,
          child: ProviderScope(
            overrides: [
              SimpleCache.provider.overrideWithValue(MemoryCache()),
              NotificationService.provider.overrideWithValue(
                FakeNotifications(),
              ),
              DevicePowerSettings.provider.overrideWithValue(FakeOppoPhone()),
              LocationService.provider.overrideWithValue(
                FakeGpsInAlexandria(),
              ),
              cityDirectoryProvider.overrideWith(
                (ref) async => testCityDirectory(),
              ),
              clockProvider.overrideWith((ref) => Stream.value(designNow)),
              todayWindowsProvider.overrideWith(
                (ref) async => designTodayWindows(),
              ),
              routerProvider.overrideWithValue(
                GoRouter(initialLocation: path, routes: appRoutes),
              ),
            ],
            child: App(translations: TestTranslations()),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));
      // The chosen language is remembered across renders, so always set it.
      final context = tester.element(find.byType(Scaffold).first);
      if (context.locale.languageCode != language) {
        await context.setLocale(Locale(language));
      }
      // Async state (permission checks, GPS → city) settles over a few frames.
      for (var i = 0; i < 3; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      await tester.runAsync(() async {
        final render =
            boundary.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final image = await render.toImage();
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        File('build/design_check/$name.png')
          ..createSync(recursive: true)
          ..writeAsBytesSync(png!.buffer.asUint8List());
      });

      // Let the splash timer fire harmlessly after unmounting.
      await tester.pumpWidget(const SizedBox());
      await tester.pump(SplashPage.duration);
    });
  }
}
