import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

/// The Library's shelves, in the design's order. Morning, evening and the
/// last third follow the windows a dua is for; "ma'thur" holds the general
/// supplications; "saved" the bookmarked ones.
enum LibraryCategory {
  morning,
  evening,
  lastThird,
  mathur,
  saved
  ;

  /// Its duas, in catalog order. [saved] is the bookmarked ids.
  List<Dua> of(DuaCatalog catalog, Set<String> saved) => [
    for (final dua in catalog.duas)
      if (switch (this) {
        morning => dua.windows.contains(DuaWindowType.morningAdhkar),
        evening => dua.windows.contains(DuaWindowType.eveningAdhkar),
        lastThird => dua.windows.contains(DuaWindowType.lastThirdOfNight),
        mathur => dua.general,
        LibraryCategory.saved => saved.contains(dua.id),
      })
        dua,
  ];
}
