import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

import '../../helpers/fakes.dart';

void main() {
  group('the bundled duas', () {
    final catalog = testDuaCatalog();
    final duas = catalog.duas;

    test('are complete, with a source to check', () {
      expect(duas, isNotEmpty);
      for (final dua in duas) {
        expect(dua.arabic, isNotEmpty, reason: dua.id);
        expect(dua.transliteration, isNotEmpty, reason: dua.id);
        expect(dua.meaning['en'], isNotEmpty, reason: dua.id);
        expect(dua.source.keys, containsAll(['ar', 'en']), reason: dua.id);
        expect(dua.url, startsWith('https://'), reason: dua.id);
        expect(dua.repeat, greaterThanOrEqualTo(1), reason: dua.id);
      }
      expect(duas.map((dua) => dua.id).toSet(), hasLength(duas.length));
    });

    test('stay flagged until Mariam verifies their sources', () {
      // Flip this only together with checking every source.
      expect(duas.where((dua) => dua.verified), isEmpty);
    });

    test('cover every window with its own duas', () {
      for (final window in DuaWindowType.values) {
        expect(
          duas.where((dua) => dua.windows.contains(window)),
          isNotEmpty,
          reason: window.name,
        );
      }
    });

    test('keep the Arabic plain: no tatweel or stray spaces after a waw', () {
      for (final dua in duas) {
        expect(dua.arabic, isNot(contains('ـ')), reason: dua.id);
        expect(
          dua.arabic,
          isNot(matches(RegExp(r'(^|\s)وَ\s'))),
          reason: dua.id,
        );
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

  test('Arabic mode shows no meaning where only English has one', () {
    const dua = Dua(
      id: 'x',
      arabic: 'x',
      transliteration: 'x',
      meaning: {'en': 'Meaning'},
    );

    expect(dua.meaningIn('ar'), isEmpty);
    expect(dua.meaningIn('en'), 'Meaning');
  });
}
