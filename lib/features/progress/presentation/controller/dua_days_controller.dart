import 'dart:async';
import 'dart:convert';

import 'package:ijaba/core/service/local/cache/base_cache.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/progress/data/model/dua_week.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dua_days_controller.g.dart';

/// The days the user finished at least one set of duas (a window's or a
/// shelf's — the completion screen showed), for "أسبوعك مع الدعاء" on Home
/// and "أيامك مع إجابة" in Settings. Only the dates, only on the phone
/// (`CacheKey.duaDays`); never shared, never notified. Days are only ever
/// added, so the count never goes down.
@Riverpod(keepAlive: true)
class DuaDays extends _$DuaDays {
  @override
  Set<DateTime> build() {
    final cache = ref.watch(SimpleCache.provider);
    final saved = cache.read(CacheKey.duaDays);
    final days = <DateTime>{
      if (saved != null)
        for (final day in jsonDecode(saved) as List) _parse(day as String),
    };
    // The first version kept dates per window (`completions`): fold them in.
    final old = cache.read(CacheKey.completions);
    if (old != null) {
      for (final dates in (jsonDecode(old) as Map).values) {
        days.addAll((dates as List).map((day) => _parse(day as String)));
      }
      unawaited(_write(cache, days));
      unawaited(cache.delete(CacheKey.completions));
    }
    return days;
  }

  /// Marks [now]'s day (once) and returns how many days of this week
  /// (from Saturday) are done — "يومك الرابع هذا الأسبوع".
  Future<int> record(DateTime now) async {
    final local = now.toLocal();
    final today = DateTime(local.year, local.month, local.day);
    if (!state.contains(today)) {
      state = {...state, today};
      await _write(ref.read(SimpleCache.provider), state);
    }
    return DuaWeek(now, state).done;
  }

  static Future<void> _write(BaseCache cache, Set<DateTime> days) =>
      cache.write(
        CacheKey.duaDays,
        jsonEncode([for (final day in days.toList()..sort()) _format(day)]),
      );

  static DateTime _parse(String day) => DateTime.parse(day);

  static String _format(DateTime day) =>
      '${day.year.toString().padLeft(4, '0')}-'
      '${day.month.toString().padLeft(2, '0')}-'
      '${day.day.toString().padLeft(2, '0')}';
}
