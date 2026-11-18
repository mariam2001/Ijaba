import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/duas/data/model/dua_occasion.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
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

    test('are verified, but for those awaiting Mariam\'s sign-off', () {
      // The base 50 were checked and signed off on 2026-11-14; the waking
      // and sleep adhkar were source-checked on 2026-11-18 (see
      // docs/DUA_SOURCES.md) and wait for her. Change this list only
      // together with that sign-off.
      const awaiting = {
        'waking-ahyana',
        'waking-afani',
        'waking-taarra',
        'waking-al-imran',
        'sleep-muawwidhat',
        'sleep-ayat-al-kursi',
        'sleep-baqarah-end',
        'sleep-bismika-rabbi',
        'sleep-khalaqta-nafsi',
        'sleep-qini-adhabak',
        'sleep-bismika-amutu',
        'sleep-subhanallah-33',
        'sleep-alhamdulillah-33',
        'sleep-allahuakbar-34',
        'sleep-rabb-as-samawat',
        'sleep-atamana',
        'sleep-fatir-as-samawat',
        'sleep-aslamtu',
      };
      expect(
        duas.where((dua) => !dua.verified).map((dua) => dua.id).toSet(),
        awaiting,
      );
    });

    test('keep each one to windows or to moments without alerts', () {
      for (final dua in duas) {
        expect(
          dua.windows.isEmpty != dua.occasions.isEmpty,
          isTrue,
          reason: dua.id,
        );
      }
    });

    test('never show the waking and sleep adhkar for a window', () {
      for (final window in [null, ...DuaWindowType.values]) {
        expect(
          catalog.forWindow(window).where((dua) => dua.occasions.isNotEmpty),
          isEmpty,
          reason: '$window',
        );
      }
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

  group('search', () {
    final catalog = testDuaCatalog();
    List<String> ids(String query) =>
        catalog.search(query).map((dua) => dua.id).toList();

    test('finds Arabic without harakat, transliteration and meaning', () {
      expect(ids('انك عفو'), contains('afw'));
      expect(ids('AFUWWUN'), contains('afw'));
      expect(ids('pardon me'), contains('afw'));
    });

    test('lists a text kept in two places once', () {
      // Ayat al-Kursi: the morning and evening adhkar, and before sleep.
      expect(ids('الحي القيوم لا تاخذه سنة'), ['ayat-al-kursi']);
    });

    test('needs two letters, and finds nothing for nonsense', () {
      expect(ids('ع'), isEmpty);
      expect(ids('qqqq'), isEmpty);
    });
  });

  group('Library shelves', () {
    final catalog = testDuaCatalog();

    test('follow the windows, the general flag and the bookmarks', () {
      expect(
        LibraryCategory.morning.of(catalog, {}),
        everyElement(
          predicate<Dua>(
            (dua) => dua.windows.contains(DuaWindowType.morningAdhkar),
          ),
        ),
      );
      expect(
        LibraryCategory.mathur.of(catalog, {}),
        everyElement(predicate<Dua>((dua) => dua.general)),
      );
      for (final category in LibraryCategory.values) {
        // The user's: none bundled.
        if (category case LibraryCategory.saved || LibraryCategory.mine) {
          continue;
        }
        expect(category.of(catalog, {}), isNotEmpty, reason: category.name);
      }
    });

    test('sleep and waking hold their adhkar, in the Hisn\'s order', () {
      final sleep = LibraryCategory.sleep.of(catalog, {});
      expect(
        sleep,
        everyElement(
          predicate<Dua>((dua) => dua.occasions.contains(DuaOccasion.sleep)),
        ),
      );
      expect(sleep.first.id, 'sleep-muawwidhat');
      // "Make them the last thing you say" (al-Bukhari 6311).
      expect(sleep.last.id, 'sleep-aslamtu');
      expect(
        LibraryCategory.waking.of(catalog, {}).map((dua) => dua.id),
        ['waking-ahyana', 'waking-afani', 'waking-taarra', 'waking-al-imran'],
      );
    });

    test('saved holds just the bookmarked, in catalog order', () {
      expect(LibraryCategory.saved.of(catalog, {}), isEmpty);
      expect(
        LibraryCategory.saved
            .of(catalog, {'rabbana-atina', 'afw'})
            .map((dua) => dua.id),
        ['afw', 'rabbana-atina'],
      );
    });
  });

  test('a window gets its own duas, or every window dua if it has none', () {
    Dua dua(
      String id,
      List<DuaWindowType> windows, [
      List<DuaOccasion> occasions = const [],
    ]) => Dua(
      id: id,
      arabic: id,
      transliteration: id,
      meaning: {'ar': id, 'en': id},
      windows: windows,
      occasions: occasions,
    );
    final catalog = DuaCatalog([
      dua('night', const [DuaWindowType.lastThirdOfNight]),
      dua('any', const []),
      dua('sleep', const [], const [DuaOccasion.sleep]),
    ]);

    expect(
      catalog.forWindow(DuaWindowType.lastThirdOfNight).map((d) => d.id),
      ['night'],
    );
    expect(
      catalog.forWindow(DuaWindowType.fridayHour).map((d) => d.id),
      ['night', 'any'],
    );
    expect(catalog.forWindow(null).map((d) => d.id), ['night', 'any']);
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
