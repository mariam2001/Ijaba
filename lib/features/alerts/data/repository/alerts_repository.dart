import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/error/guard.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_text.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// What [AlertsRepository.reschedule] scheduled, and with which alarm type
/// (it falls back to inexact alarms while exact ones aren't permitted).
typedef ScheduleResult = ({
  List<PlannedAlert> alerts,
  AndroidScheduleMode mode,
});

class AlertsRepository {
  const AlertsRepository(
    this._notifications, {
    PrayerTimesCalculator calculator = const PrayerTimesCalculator(),
    AlertPlanner planner = const AlertPlanner(),
  }) : _calculator = calculator,
       _planner = planner;

  static final provider = Provider<AlertsRepository>(
    (ref) => AlertsRepository(ref.watch(NotificationService.provider)),
  );

  /// How many days ahead alerts stay scheduled. The app tops this up every
  /// time it is opened.
  static const horizonDays = 7;

  final NotificationService _notifications;
  final PrayerTimesCalculator _calculator;
  final AlertPlanner _planner;

  /// Replaces all scheduled window alerts with a fresh plan for the coming
  /// [horizonDays] days.
  FutureEither<ScheduleResult> reschedule({
    required GeoPoint location,
    required PrayerSettings settings,
    required Set<DuaWindowType> enabled,
    required AndroidScheduleMode mode,
    required String localeName,
  }) => guard(() async {
    final now = DateTime.now();
    final days = [
      // Starts at yesterday: after midnight, yesterday's night (its last
      // third) may still be ahead.
      for (var offset = -1; offset < horizonDays; offset++)
        _calculator.calculate(
          date: DateTime(now.year, now.month, now.day + offset),
          location: location,
          settings: settings,
        ),
    ];
    final alerts = _planner.plan(
      days: days,
      enabled: enabled,
      now: now.toUtc(),
    );
    final effectiveMode = await _notifications.canScheduleExactAlarms()
        ? mode
        : AndroidScheduleMode.inexactAllowWhileIdle;
    final text = AlertText.forLocale(localeName);

    await _notifications.ensureChannels(
      name: LocaleKeys.alerts_channel.tr(),
      quietName: LocaleKeys.alerts_quiet_channel.tr(),
    );
    await _notifications.cancelWindowAlerts();
    for (final alert in alerts) {
      await _notifications.schedule(
        id: alert.id,
        at: alert.at,
        title: text.title(alert),
        body: text.body(alert),
        mode: effectiveMode,
        quiet: alert.isQuiet,
        payload: alert.windows.map((window) => window.type.name).join(','),
      );
    }
    return (alerts: alerts, mode: effectiveMode);
  });

  /// Developer tool: a one-off alert [after] from now, to check delivery on a
  /// real device. Its body states the intended time to compare against.
  FutureEither<DateTime> scheduleTest({
    required Duration after,
    required AndroidScheduleMode mode,
  }) => guard(() async {
    final at = DateTime.now().add(after).toUtc();
    final effectiveMode = await _notifications.canScheduleExactAlarms()
        ? mode
        : AndroidScheduleMode.inexactAllowWhileIdle;
    await _notifications.schedule(
      // Below NotificationService.firstWindowAlertId, so rescheduling the
      // windows leaves pending test alerts alone.
      id: at.millisecondsSinceEpoch ~/ 1000 % 900 + 1,
      at: at,
      title: 'Ijaba test alert',
      body:
          'Scheduled for ${DateFormat.Hms().format(at.toLocal())} '
          '(${effectiveMode.name})',
      mode: effectiveMode,
    );
    return at;
  });
}
