import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enabled_windows_controller.g.dart';

/// Which windows alert, as switched on the Windows screen. Windows that are
/// off still show on Home, faded as silent.
@Riverpod(keepAlive: true)
class EnabledWindowTypes extends _$EnabledWindowTypes {
  /// As in the design: everything on except after-prayer, which the
  /// handover keeps silent by default.
  static const defaults = {
    DuaWindowType.lastThirdOfNight,
    DuaWindowType.adhanToIqama,
    DuaWindowType.fridayHour,
    DuaWindowType.morningAdhkar,
    DuaWindowType.eveningAdhkar,
  };

  @override
  Set<DuaWindowType> build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.enabledWindows);
    if (saved == null) return defaults;
    final byName = DuaWindowType.values.asNameMap();
    return {
      for (final name in (jsonDecode(saved) as List).cast<String>())
        ?byName[name],
    };
  }

  /// Switches [types] on or off together (one switch covers both adhkar).
  Future<void> setEnabled(Set<DuaWindowType> types, {required bool on}) async {
    state = on ? {...state, ...types} : state.difference(types);
    await ref
        .read(SimpleCache.provider)
        .write(
          CacheKey.enabledWindows,
          jsonEncode([for (final type in state) type.name]),
        );
  }
}
