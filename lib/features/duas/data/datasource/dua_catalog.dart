import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ijaba/core/utils/search_text.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dua_catalog.g.dart';

/// The bundled duas (`assets/data/duas.json`), in file order.
class DuaCatalog {
  const DuaCatalog(this.duas);

  factory DuaCatalog.fromJson(Json json) => DuaCatalog([
    for (final dua in json['duas'] as List) Dua.fromJson(dua as Json),
  ]);

  final List<Dua> duas;

  /// The duas for [window]; every dua when none is tagged for it (so a
  /// window never opens onto an empty screen while content is being added).
  List<Dua> forWindow(DuaWindowType? window) {
    final tagged = [
      for (final dua in duas)
        if (window != null && dua.windows.contains(window)) dua,
    ];
    return tagged.isNotEmpty ? tagged : duas;
  }

  Dua? byId(String id) => duas.where((dua) => dua.id == id).firstOrNull;

  /// Duas whose Arabic, transliteration or meaning contains [query] —
  /// without regard to harakat, hamza forms or case. Nothing for under two
  /// letters.
  List<Dua> search(String query) {
    final needle = searchable(query);
    if (needle.length < 2) return const [];
    return [
      for (final dua in duas)
        if ([
          dua.arabic,
          dua.transliteration,
          ...dua.meaning.values,
        ].any((text) => searchable(text).contains(needle)))
          dua,
    ];
  }
}

/// Loaded once, on first use.
@Riverpod(keepAlive: true)
Future<DuaCatalog> duaCatalog(Ref ref) async {
  final raw = await rootBundle.loadString('assets/data/duas.json');
  return DuaCatalog.fromJson(jsonDecode(raw) as Json);
}
