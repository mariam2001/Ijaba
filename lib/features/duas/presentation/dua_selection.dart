import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/library_categories.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Which duas the Dua screen steps through, and what its header calls them.
sealed class DuaSelection {
  const DuaSelection();

  /// [saved] is the bookmarked ids.
  List<Dua> duasIn(DuaCatalog catalog, Set<String> saved);

  String title(BuildContext context);
}

/// A window's duas — from Home or a tapped alert. Null: an unknown window
/// name in the link, which shows every dua.
final class WindowDuas extends DuaSelection {
  const WindowDuas(this.window);

  final DuaWindowType? window;

  @override
  List<Dua> duasIn(DuaCatalog catalog, Set<String> saved) =>
      catalog.forWindow(window);

  @override
  String title(BuildContext context) {
    final window = this.window;
    return context.tr(
      window == null ? LocaleKeys.tabs_duas : windowNameKey(window),
    );
  }
}

/// A Library shelf.
final class CategoryDuas extends DuaSelection {
  const CategoryDuas(this.category);

  final LibraryCategory category;

  @override
  List<Dua> duasIn(DuaCatalog catalog, Set<String> saved) =>
      category.of(catalog, saved);

  @override
  String title(BuildContext context) => context.tr(category.titleKey);
}

/// One dua, found by search.
final class OneDua extends DuaSelection {
  const OneDua(this.id);

  final String id;

  @override
  List<Dua> duasIn(DuaCatalog catalog, Set<String> saved) => [
    ?catalog.byId(id),
  ];

  @override
  String title(BuildContext context) => context.tr(LocaleKeys.library_title);
}
