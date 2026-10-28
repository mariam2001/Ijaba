import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

import '../../helpers/fakes.dart';

void main() {
  group('the bundled duas', () {
    final duas = testDuaCatalog().duas;

    test('are complete in both languages', () {
      expect(duas, isNotEmpty);
      for (final dua in duas) {
        expect(dua.arabic, isNotEmpty, reason: dua.id);
        expect(dua.transliteration, isNotEmpty, reason: dua.id);
        expect(dua.meaning.keys, containsAll(['ar', 'en']), reason: dua.id);
        expect(dua.repeat, greaterThanOrEqualTo(1), reason: dua.id);
      }
      expect(duas.map((dua) => dua.id).toSet(), hasLength(duas.length));
    });

    test('are only marked verified with a source in both languages', () {
      for (final dua in duas.where((dua) => dua.verified)) {
        expect(dua.source.keys, containsAll(['ar', 'en']), reason: dua.id);
      }
    });
  });

  test('a window gets its own duas, or every dua if it has none', () {
    Dua dua(String id, List<DuaWindowType> windows) => Dua(
      id: id,
      arabic: id,
      transliteration: id,
      meaning: {'ar': id, 'en': id},
      windows: windows,
    );
    final catalog = DuaCatalog([
      dua('night', const [DuaWindowType.lastThirdOfNight]),
      dua('any', const []),
    ]);

    expect(
      catalog.forWindow(DuaWindowType.lastThirdOfNight).map((d) => d.id),
      ['night'],
    );
    expect(
      catalog.forWindow(DuaWindowType.fridayHour).map((d) => d.id),
      ['night', 'any'],
    );
    expect(catalog.forWindow(null), hasLength(2));
  });
}
