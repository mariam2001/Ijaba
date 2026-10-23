import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

part 'planned_alert.freezed.dart';

/// One notification to schedule. Windows whose alerts fall in the same
/// minute share it, so the user never gets two at once.
@freezed
abstract class PlannedAlert with _$PlannedAlert {
  const PlannedAlert._();

  const factory PlannedAlert({
    /// Minutes since the epoch of [at]: stable, so re-planning reproduces it.
    required int id,

    /// When to fire, as a UTC instant on a whole minute.
    required DateTime at,

    /// The windows this alert announces, in [DuaWindowType] order.
    required List<DuaWindow> windows,
  }) = _PlannedAlert;

  /// After-prayer alerts are silent by default (per the design).
  bool get isQuiet =>
      windows.every((window) => window.type == DuaWindowType.afterPrayer);
}
