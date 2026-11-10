import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/data/model/today_windows.dart';

/// What an alert carries for when it's tapped: the names of its windows,
/// comma-separated ("adhanToIqama,morningAdhkar").
abstract final class AlertPayload {
  static String encode(Iterable<DuaWindowType> types) =>
      types.map((type) => type.name).join(',');

  /// The window whose duas a tap opens: of several sharing the alert, the
  /// one Home would feature. Null for anything else (test alerts carry no
  /// payload).
  static DuaWindowType? windowToOpen(String? payload) {
    final byName = DuaWindowType.values.asNameMap();
    final types = [
      for (final name in (payload ?? '').split(',')) ?byName[name.trim()],
    ];
    if (types.isEmpty) return null;
    const priority = TodayWindows.featurePriority;
    return types.reduce(
      (a, b) => priority.indexOf(a) <= priority.indexOf(b) ? a : b,
    );
  }
}
