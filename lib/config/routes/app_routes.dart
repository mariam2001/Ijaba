/// Route paths. Register each one in `routes.dart`.
abstract final class AppRoutes {
  static const splash = '/';

  // Main tabs.
  static const home = '/home';
  static const duas = '/duas';
  static const windows = '/windows';
  static const settings = '/settings';
  static const mainTabs = [home, duas, windows, settings];

  // Onboarding, in order.
  static const language = '/onboarding/language';
  static const welcome = '/onboarding/welcome';
  static const location = '/onboarding/location';
  static const cityPicker = '/onboarding/location/city';
  static const permissions = '/onboarding/permissions';

  /// Developer-only notification test page; remove before release.
  static const alertsDebug = '/debug/alerts';
}
