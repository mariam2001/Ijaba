import 'dart:convert';

import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_log_controller.g.dart';

/// The days the user finished each set of duas (a window's, a shelf's), for
/// the completion screen's "ليلتك الرابعة هذا الشهر". Kept on the phone
/// (`CacheKey.completions`): `{key: ["2026-11-19", …]}`, the current and
/// last month only.
@Riverpod(keepAlive: true)
class CompletionLog extends _$CompletionLog {
  @override
  Map<String, List<String>> build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.completions);
    if (saved == null) return const {};
    return {
      for (final MapEntry(:key, :value) in (jsonDecode(saved) as Map).entries)
        key as String: (value as List).cast<String>(),
    };
  }

  /// Records [key] as finished on [now]'s date (once a day) and returns
  /// how many days this month it has been: 1 for the first.
  Future<int> record(String key, DateTime now) async {
    final local = now.toLocal();
    final today = _day(local);
    final month = today.substring(0, 7);
    final lastMonth = _day(
      DateTime(local.year, local.month - 1),
    ).substring(0, 7);
    final days = {...?state[key], today};
    state = {
      for (final MapEntry(key: k, :value) in {
        ...state,
        key: days.toList(),
      }.entries)
        k: [
          for (final day in value)
            if (day.startsWith(month) || day.startsWith(lastMonth)) day,
        ]..sort(),
    };
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.completions, jsonEncode(state));
    return state[key]!.where((day) => day.startsWith(month)).length;
  }

  static String _day(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
