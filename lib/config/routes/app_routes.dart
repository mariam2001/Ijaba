/// Route paths. Register each one in `routes.dart`.
abstract final class AppRoutes {
  static const splash = '/';

  // Main tabs.
  static const home = '/home';
  static const duas = '/duas';
  static const windows = '/windows';
  static const settings = '/settings';
  static const mainTabs = [home, duas, windows, settings];

  /// The Library with its search field focused (each call a new request).
  static const searchParam = 'search';
  static String librarySearch() =>
      '$duas?$searchParam=${DateTime.now().microsecondsSinceEpoch}';

  /// The Dua screen for a window: [duaFor] with its `DuaWindowType` name.
  static const dua = '/dua';
  static String duaFor(String window) => '$dua/$window';

  /// The Dua screen for a Library shelf (a `LibraryCategory` name), or for
  /// one dua (its id).
  static const library = '/library';
  static String libraryCategory(String category) => '$library/$category';
  static String libraryDua(String id) => '$library/dua/$id';

  // The user's own duas: the list, a new one, one to edit.
  static const myDuas = '/my-duas';
  static const myDuaNew = '$myDuas/new';
  static String myDuaEdit(String id) => '$myDuas/edit/$id';

  /// "تقبّل الله منك", after the last dua (takes `CompletionArgs` as extra).
  static const completion = '/done';

  /// آداب الدعاء, from Home.
  static const etiquette = '/etiquette';

  // Onboarding, in order.
  static const language = '/onboarding/language';
  static const welcome = '/onboarding/welcome';
  static const location = '/onboarding/location';
  static const cityPicker = '/onboarding/location/city';
  static const permissions = '/onboarding/permissions';

  /// Developer-only notification test page; remove before release.
}
