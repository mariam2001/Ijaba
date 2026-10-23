import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_mode_controller.g.dart';

/// Which Android alarm type the alerts use — an experiment knob for the
/// ColorOS reliability test:
/// - `exactAllowWhileIdle`: standard exact reminder alarm (the default).
/// - `alarmClock`: treated like a user alarm; strongest against battery
///   savers, but Android shows an alarm icon in the status bar.
@Riverpod(keepAlive: true)
class AlarmModeController extends _$AlarmModeController {
  @override
  AndroidScheduleMode build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.alarmMode);
    return AndroidScheduleMode.values.asNameMap()[saved] ??
        AndroidScheduleMode.exactAllowWhileIdle;
  }

  Future<void> select(AndroidScheduleMode mode) async {
    state = mode;
    await ref.read(SimpleCache.provider).write(CacheKey.alarmMode, mode.name);
  }
}
