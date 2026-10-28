import 'package:ijaba/core/utils/global_states.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/alerts/data/repository/alerts_repository.dart';
import 'package:ijaba/features/alerts/presentation/controller/alarm_mode_controller.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alerts_controller.g.dart';

/// Keeps the coming days' window alerts scheduled. The app calls
/// [reschedule] on start, on every return to the foreground, and when the
/// language or the enabled windows change.
@Riverpod(keepAlive: true)
class AlertsController extends _$AlertsController {
  DateTime? _lastSuccess;

  /// A forced run asked for while one was in progress (e.g. several
  /// switches flipped quickly): it runs once the current one finishes, so
  /// the last change always gets scheduled.
  String? _pendingLocale;

  @override
  GlobalStates<ScheduleResult> build() => const GlobalStates.initial();

  /// Without [force], skips if the last successful run was under 30 minutes
  /// ago — returning to the app shouldn't redo ~70 alarms every time.
  Future<void> reschedule({
    required String localeName,
    bool force = false,
  }) async {
    final last = _lastSuccess;
    final location = ref.read(prayerLocationProvider);
    if (force && state.isLoading) {
      _pendingLocale = localeName;
      return;
    }
    if (location == null ||
        state.isLoading ||
        (!force &&
            last != null &&
            DateTime.now().difference(last) < const Duration(minutes: 30))) {
      // No location until onboarding finishes; nothing to schedule yet.
      return;
    }

    state = const GlobalStates.loading();
    final result = await ref
        .read(AlertsRepository.provider)
        .reschedule(
          location: location,
          settings: ref.read(prayerSettingsProvider),
          enabled: ref.read(enabledWindowTypesProvider),
          mode: ref.read(alarmModeControllerProvider),
          localeName: localeName,
        );
    if (!ref.mounted) return;
    state = result.fold((failure) => GlobalStates.fail(failure.message), (
      scheduled,
    ) {
      _lastSuccess = DateTime.now();
      return GlobalStates.success(scheduled);
    });

    final pending = _pendingLocale;
    if (pending != null) {
      _pendingLocale = null;
      await reschedule(localeName: pending, force: true);
    }
  }
}

/// Whether the two permissions alerts depend on are granted.
@riverpod
Future<({bool notifications, bool exactAlarms})> alertPermissions(
  Ref ref,
) async {
  final notifications = ref.watch(NotificationService.provider);
  return (
    notifications: await notifications.notificationsEnabled(),
    exactAlarms: await notifications.canScheduleExactAlarms(),
  );
}
