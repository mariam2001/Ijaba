import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_duas_controller.g.dart';

/// Ids of the duas the user bookmarked (the Library's "saved" list).
@Riverpod(keepAlive: true)
class SavedDuas extends _$SavedDuas {
  @override
  Set<String> build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.savedDuas);
    return saved == null
        ? const {}
        : (jsonDecode(saved) as List).cast<String>().toSet();
  }

  Future<void> toggle(String id) async {
    state = state.contains(id) ? state.difference({id}) : {...state, id};
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.savedDuas, jsonEncode(state.toList()));
  }
}
