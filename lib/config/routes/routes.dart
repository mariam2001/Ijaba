import 'package:go_router/go_router.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/routes/main_shell.dart';
import 'package:ijaba/features/alerts/presentation/pages/alerts_debug_page.dart';
import 'package:ijaba/features/duas/presentation/pages/duas_page.dart';
import 'package:ijaba/features/home/presentation/pages/home_page.dart';
import 'package:ijaba/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:ijaba/features/onboarding/presentation/pages/city_picker_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/language_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/location_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/permissions_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/splash_page.dart';
import 'package:ijaba/features/onboarding/presentation/pages/welcome_page.dart';
import 'package:ijaba/features/settings/presentation/pages/settings_page.dart';
import 'package:ijaba/features/windows/presentation/pages/windows_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

final appRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.splash,
    builder: (context, state) => const SplashPage(),
  ),
  // The four main tabs, each with its own navigation stack.
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        MainShell(navigationShell: navigationShell),
    branches: [
      for (final (path, page) in const [
        (AppRoutes.home, HomePage()),
        (AppRoutes.duas, DuasPage()),
        (AppRoutes.windows, WindowsPage()),
        (AppRoutes.settings, SettingsPage()),
      ])
        StatefulShellBranch(
          routes: [GoRoute(path: path, builder: (context, state) => page)],
        ),
    ],
  ),
  GoRoute(
    path: AppRoutes.language,
    builder: (context, state) => const LanguagePage(),
  ),
  GoRoute(
    path: AppRoutes.welcome,
    builder: (context, state) => const WelcomePage(),
  ),
  GoRoute(
    path: AppRoutes.location,
    builder: (context, state) => const LocationPage(),
  ),
  GoRoute(
    path: AppRoutes.cityPicker,
    builder: (context, state) => const CityPickerPage(),
  ),
  GoRoute(
    path: AppRoutes.permissions,
    builder: (context, state) => const PermissionsPage(),
  ),
  GoRoute(
    path: AppRoutes.alertsDebug,
    builder: (context, state) => const AlertsDebugPage(),
  ),
];

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    // The main tabs need a location and permissions: onboarding first.
    redirect: (context, state) =>
        AppRoutes.mainTabs.contains(state.matchedLocation) &&
            !ref.read(onboardingControllerProvider)
        ? AppRoutes.language
        : null,
    routes: appRoutes,
  );
  ref.onDispose(router.dispose);
  return router;
}
