import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/duas/data/model/dua_occasion.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

/// The Library's shelves, in the design's order, with the alert-free
/// adhkar for sleep and waking after the evening's. Morning, evening and
/// the last third follow the windows a dua is for; sleep and waking its
/// occasions; "ma'thur" holds the general supplications; "my duas" the
/// ones the user wrote; "saved" the bookmarked ones.
enum LibraryCategory {
  morning,
  evening,
  sleep,
  waking,
  lastThird,
  mathur,
  mine,
  saved
  ;

  /// Its duas, in catalog order. [saved] is the bookmarked ids.
  List<Dua> of(DuaCatalog catalog, Set<String> saved) => [
    for (final dua in catalog.duas)
      if (switch (this) {
        morning => dua.windows.contains(DuaWindowType.morningAdhkar),
        evening => dua.windows.contains(DuaWindowType.eveningAdhkar),
        sleep => dua.occasions.contains(DuaOccasion.sleep),
        waking => dua.occasions.contains(DuaOccasion.waking),
        lastThird => dua.windows.contains(DuaWindowType.lastThirdOfNight),
        mathur => dua.general,
        mine => dua.mine,
        LibraryCategory.saved => saved.contains(dua.id),
      })
        dua,
  ];
}
