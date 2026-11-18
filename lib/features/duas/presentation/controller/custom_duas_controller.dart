import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/duas/data/model/custom_dua.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_duas_controller.g.dart';

/// The duas the user wrote, in the order they were added. Saved on the
/// phone only (`CacheKey.customDuas`), like every other setting.
@Riverpod(keepAlive: true)
class CustomDuas extends _$CustomDuas {
  @override
  List<CustomDua> build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.customDuas);
    if (saved == null) return const [];
    return [
      for (final json in jsonDecode(saved) as List)
        CustomDua.fromJson(json as Json),
    ];
  }

  CustomDua? byId(String id) => state.where((dua) => dua.id == id).firstOrNull;

  /// Adds a dua; returns its id.
  Future<String> add(String text, List<DuaWindowType> windows) async {
    final id = 'mine-${DateTime.now().microsecondsSinceEpoch}';
    await _save([
      ...state,
      CustomDua(id: id, text: text.trim(), windows: _ordered(windows)),
    ]);
    return id;
  }

  Future<void> edit(
    String id, {
    required String text,
    required List<DuaWindowType> windows,
  }) => _save([
    for (final dua in state)
      dua.id == id
          ? dua.copyWith(text: text.trim(), windows: _ordered(windows))
          : dua,
  ]);

  Future<void> remove(String id) => _save([
    for (final dua in state)
      if (dua.id != id) dua,
  ]);

  /// In the windows' own order, whatever order they were ticked in.
  List<DuaWindowType> _ordered(List<DuaWindowType> windows) => [
    for (final window in DuaWindowType.values)
      if (windows.contains(window)) window,
  ];

  Future<void> _save(List<CustomDua> duas) async {
    state = duas;
    await ref
        .read(SimpleCache.provider)
        .write(
          CacheKey.customDuas,
          jsonEncode([for (final dua in duas) dua.toJson()]),
        );
  }
}
