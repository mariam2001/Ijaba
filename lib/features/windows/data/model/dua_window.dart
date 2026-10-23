import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

part 'dua_window.freezed.dart';

/// One occurrence of a window, as UTC instants.
@freezed
abstract class DuaWindow with _$DuaWindow {
  const DuaWindow._();

  const factory DuaWindow({
    required DuaWindowType type,
    required DateTime start,
    required DateTime end,

    /// The prayer the window belongs to (adhan-to-iqama and after-prayer).
    Prayer? prayer,
  }) = _DuaWindow;

  /// Whether [moment] falls in the window: start inclusive, end exclusive.
  bool isOpenAt(DateTime moment) =>
      !moment.isBefore(start) && moment.isBefore(end);
}
