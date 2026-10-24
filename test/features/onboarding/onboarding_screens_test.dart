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
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/features/location/data/datasource/location_service.dart';
import 'package:ijaba/features/onboarding/data/datasource/device_power_settings.dart';
import 'package:ijaba/features/onboarding/presentation/pages/language_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/location_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/permissions_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/splash_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/welcome_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

/// Every onboarding screen lays out without overflow from a small phone to a
/// large one. (Pixel-level fidelity at 390 × 844 is checked separately with
/// tool/design_check.)
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
    await initializeDateFormatting();
  });

  const phones = {
    'small (360 × 640)': Size(360, 640),
    'design (390 × 844)': Size(390, 844),
    'large (430 × 932)': Size(430, 932),
  };
  const screens = {
    AppRoutes.splash: SplashPage,
    AppRoutes.language: LanguagePage,
    AppRoutes.welcome: WelcomePage,
    AppRoutes.location: LocationPage,
    AppRoutes.permissions: PermissionsPage,
  };

  for (final MapEntry(key: phone, value: size) in phones.entries) {
    for (final MapEntry(key: path, value: page) in screens.entries) {
      testWidgets('$path fits a $phone phone', (tester) async {
        tester.view
          ..physicalSize = size
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          ProviderScope(
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
              routerProvider.overrideWithValue(
                GoRouter(initialLocation: path, routes: appRoutes),
              ),
            ],
            child: App(translations: TestTranslations()),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(page), findsOneWidget);
        // A RenderFlex overflow is reported as an exception.
        expect(tester.takeException(), isNull);

        // Let the splash timer fire harmlessly after unmounting.
        await tester.pumpWidget(const SizedBox());
        await tester.pump(SplashPage.duration);
      });
    }
  }
}
