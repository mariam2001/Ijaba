import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/controller/custom_duas_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dua_catalog_controller.g.dart';

/// Every dua the app shows: the bundled ones, then the user's own (so on a
/// window's Dua screen theirs come after the sourced duas, and search and
/// the Library find them too). Updates when they add, edit or delete one.
@Riverpod(keepAlive: true)
Future<DuaCatalog> duaCatalog(Ref ref) async {
  final bundled = await ref.watch(bundledDuaCatalogProvider.future);
  final mine = ref.watch(customDuasProvider);
  return DuaCatalog([
    ...bundled.duas,
    for (final dua in mine) dua.toDua(),
  ]);
}
