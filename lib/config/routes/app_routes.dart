/// Route paths. Register each one in `routes.dart`.
abstract final class AppRoutes {
  static const splash = '/';
  static const home = '/home';

  // Onboarding, in order.
  static const language = '/onboarding/language';
  static const welcome = '/onboarding/welcome';
  static const location = '/onboarding/location';
  static const cityPicker = '/onboarding/location/city';
  static const permissions = '/onboarding/permissions';

  /// Developer-only notification test page; remove before release.
  static const alertsDebug = '/debug/alerts';
}
