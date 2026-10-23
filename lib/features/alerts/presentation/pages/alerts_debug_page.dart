import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/utils/global_states.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_text.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/alerts/data/repository/alerts_repository.dart';
import 'package:ijaba/features/alerts/presentation/controller/alarm_mode_controller.dart';
import 'package:ijaba/features/alerts/presentation/controller/alerts_controller.dart';

const _colorOsChecklist = '''
For Ijaba on the Oppo (wording varies by ColorOS version):
• Settings → Apps → App management → Ijaba → Battery usage: allow background activity and auto launch (or "Don't optimize").
• Recent apps: pull down on Ijaba's card (or use its menu) → Lock, so clearing recents doesn't stop it.
• Notifications for Ijaba: allowed, including on the lock screen.
Test with the screen off and the phone NOT charging — charging lifts the battery restrictions we're testing.''';

/// Developer tool for build step 3: prove alerts fire on a real phone before
/// the real UI exists. English-only on purpose; remove before release.
class AlertsDebugPage extends HookConsumerWidget {
  const AlertsDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeName = context.locale.toString();
    final permissions = ref.watch(alertPermissionsProvider);
    final mode = ref.watch(alarmModeControllerProvider);
    final schedule = ref.watch(alertsControllerProvider);
    final notifications = ref.read(NotificationService.provider);

    // Returning from system settings: show the updated permission state.
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) {
        ref.invalidate(alertPermissionsProvider);
      }
    });

    Future<void> reschedule() => ref
        .read(alertsControllerProvider.notifier)
        .reschedule(localeName: localeName, force: true);

    Future<void> scheduleTest(Duration after) async {
      final result = await ref
          .read(AlertsRepository.provider)
          .scheduleTest(after: after, mode: mode);
      if (!context.mounted) return;
      final message = result.fold(
        (failure) => failure.message,
        (at) => 'Test alert set for ${DateFormat.Hms().format(at.toLocal())}',
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: const Text('Alert test (developer)')),
        body: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            const _Heading('1. Permissions'),
            permissions.when(
              data: (granted) => Column(
                children: [
                  _PermissionRow(
                    label: 'Notifications',
                    granted: granted.notifications,
                    action: 'Allow',
                    onPressed: () async {
                      await notifications.requestNotificationsPermission();
                      ref.invalidate(alertPermissionsProvider);
                    },
                  ),
                  _PermissionRow(
                    label: 'Exact alarms',
                    granted: granted.exactAlarms,
                    action: 'Open settings',
                    onPressed: notifications.openExactAlarmSettings,
                  ),
                ],
              ),
              loading: () => const LinearProgressIndicator(),
              error: (error, _) => Text('$error'),
            ),
            const _Heading('2. Oppo battery settings'),
            const Text(_colorOsChecklist),
            const _Heading('3. Alarm type'),
            SegmentedButton<AndroidScheduleMode>(
              segments: const [
                ButtonSegment(
                  value: AndroidScheduleMode.exactAllowWhileIdle,
                  label: Text('Exact'),
                ),
                ButtonSegment(
                  value: AndroidScheduleMode.alarmClock,
                  label: Text('Alarm clock'),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (selection) async {
                await ref
                    .read(alarmModeControllerProvider.notifier)
                    .select(selection.single);
                await reschedule();
              },
            ),
            const _Heading('4. Quick test'),
            Wrap(
              spacing: 8.w,
              children: [
                for (final minutes in const [1, 5, 30])
                  OutlinedButton(
                    onPressed: () => scheduleTest(Duration(minutes: minutes)),
                    child: Text('In $minutes min'),
                  ),
              ],
            ),
            const _Heading('5. Scheduled windows (Alexandria)'),
            FilledButton(
              onPressed: schedule.isLoading ? null : reschedule,
              child: const Text('Reschedule now'),
            ),
            SizedBox(height: 8.h),
            switch (schedule) {
              GlobalStatesSuccess(:final data) => _ScheduledList(
                result: data,
                text: AlertText.forLocale(localeName),
              ),
              GlobalStatesFail(:final message) => Text(
                message,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              _ => const LinearProgressIndicator(),
            },
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
    child: Text(text, style: Theme.of(context).textTheme.titleMedium),
  );
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.label,
    required this.granted,
    required this.action,
    required this.onPressed,
  });

  final String label;
  final bool granted;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        granted ? Icons.check_circle : Icons.error_outline,
        color: granted ? colors.primary : colors.error,
      ),
      title: Text(label),
      trailing: granted
          ? null
          : TextButton(onPressed: onPressed, child: Text(action)),
    );
  }
}

class _ScheduledList extends StatelessWidget {
  const _ScheduledList({required this.result, required this.text});

  final ScheduleResult result;
  final AlertText text;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEE d MMM, HH:mm', 'en');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${result.alerts.length} alerts · ${result.mode.name}'),
        for (final alert in result.alerts)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              alert.isQuiet
                  ? Icons.notifications_off_outlined
                  : Icons.notifications_active_outlined,
            ),
            title: Text(text.title(alert)),
            subtitle: Text(
              '${format.format(alert.at.toLocal())} — ${text.body(alert)}',
            ),
          ),
      ],
    );
  }
}
