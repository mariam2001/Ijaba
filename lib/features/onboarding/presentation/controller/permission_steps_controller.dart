import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/onboarding/data/datasource/device_power_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_steps_controller.g.dart';

/// The three things alerts need, in the order the Permissions screen asks
/// for them. [battery] can't be read back from the system, so it counts as
/// done once its settings screen has been opened.
typedef PermissionSteps = ({
  bool notifications,
  bool exactAlarms,
  bool battery,

  /// "Oppo", "realme", "OnePlus" when the phone has a brand-specific
  /// battery setting; null for the generic step.
  String? brand,
});

extension PermissionStepsProgress on PermissionSteps {
  /// Index of the first step still to do; 3 when all are done.
  int get current => !notifications
      ? 0
      : !exactAlarms
      ? 1
      : !battery
      ? 2
      : 3;
}

@riverpod
class PermissionStepsController extends _$PermissionStepsController {
  @override
  Future<PermissionSteps> build() async {
    final notifications = ref.watch(NotificationService.provider);
    return (
      notifications: await notifications.notificationsEnabled(),
      exactAlarms: await notifications.canScheduleExactAlarms(),
      battery: false,
      brand: await ref.watch(DevicePowerSettings.provider).brand(),
    );
  }

  /// Re-reads the system permissions, e.g. back from the settings app.
  Future<void> refresh() async {
    final steps = state.value;
    if (steps == null) return;
    final notifications = ref.read(NotificationService.provider);
    final updated = (
      notifications: await notifications.notificationsEnabled(),
      exactAlarms: await notifications.canScheduleExactAlarms(),
      battery: steps.battery,
      brand: steps.brand,
    );
    if (ref.mounted) state = AsyncData(updated);
  }

  /// Performs the current step. The battery step is marked done right away;
  /// the user finishes it in the settings app.
  Future<void> runCurrent() async {
    final steps = state.value;
    if (steps == null) return;
    switch (steps.current) {
      case 0:
        await ref
            .read(NotificationService.provider)
            .requestNotificationsPermission();
        await refresh();
      case 1:
        await ref.read(NotificationService.provider).openExactAlarmSettings();
      case 2:
        await ref.read(DevicePowerSettings.provider).open();
        final latest = state.value ?? steps;
        if (ref.mounted) {
          state = AsyncData((
            notifications: latest.notifications,
            exactAlarms: latest.exactAlarms,
            battery: true,
            brand: latest.brand,
          ));
        }
    }
  }
}
