import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:timezone/timezone.dart' as tz;

/// Thin wrapper over flutter_local_notifications.
///
/// Alerts are scheduled at absolute UTC instants, so they stay correct across
/// DST changes and device time-zone changes; the plugin re-registers them
/// after a reboot.
class NotificationService {
  NotificationService(this._plugin);

  static final provider = Provider<NotificationService>(
    (ref) => NotificationService(FlutterLocalNotificationsPlugin()),
  );

  /// Window alerts use ids from here up; lower ids (test alerts) survive
  /// [cancelWindowAlerts].
  static const firstWindowAlertId = 1000;

  static const _channelId = 'dua_windows';
  static const _quietChannelId = 'dua_windows_quiet';

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _initialization;
  String _channelName = 'Dua windows';
  String _quietChannelName = 'Quiet reminders';

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  Future<void> _ensureInitialized() => _initialization ??= _plugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('ic_stat_ijaba'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    ),
  );

  Future<bool> notificationsEnabled() async {
    await _ensureInitialized();
    return await _android?.areNotificationsEnabled() ?? true;
  }

  /// Android 13+ runtime prompt.
  Future<bool> requestNotificationsPermission() async {
    await _ensureInitialized();
    return await _android?.requestNotificationsPermission() ?? true;
  }

  Future<bool> canScheduleExactAlarms() async {
    await _ensureInitialized();
    return await _android?.canScheduleExactNotifications() ?? true;
  }

  /// Opens the system "Alarms & reminders" page for this app.
  Future<void> openExactAlarmSettings() async {
    await _ensureInitialized();
    await _android?.requestExactAlarmsPermission();
  }

  /// Creates (or renames) the two channels. Their names show in the system
  /// notification settings, so they follow the app language.
  Future<void> ensureChannels({
    required String name,
    required String quietName,
  }) async {
    await _ensureInitialized();
    _channelName = name;
    _quietChannelName = quietName;
    await _android?.createNotificationChannel(
      AndroidNotificationChannel(_channelId, name, importance: Importance.high),
    );
    await _android?.createNotificationChannel(
      AndroidNotificationChannel(
        _quietChannelId,
        quietName,
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      ),
    );
  }

  Future<void> schedule({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    required AndroidScheduleMode mode,
    bool quiet = false,
    String? payload,
  }) async {
    await _ensureInitialized();
    await _plugin.zonedSchedule(
      id: id,
      scheduledDate: tz.TZDateTime.from(at, tz.UTC),
      title: title,
      body: body,
      payload: payload,
      androidScheduleMode: mode,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          quiet ? _quietChannelId : _channelId,
          quiet ? _quietChannelName : _channelName,
          importance: quiet ? Importance.low : Importance.high,
          priority: quiet ? Priority.low : Priority.high,
          category: AndroidNotificationCategory.reminder,
          color: AppColors.green,
          styleInformation: BigTextStyleInformation(body),
        ),
      ),
    );
  }

  /// Cancels every scheduled window alert, leaving test alerts alone.
  Future<void> cancelWindowAlerts() async {
    await _ensureInitialized();
    final pending = await _plugin.pendingNotificationRequests();
    for (final request in pending) {
      if (request.id >= firstWindowAlertId) {
        await _plugin.cancel(id: request.id);
      }
    }
  }

  Future<List<PendingNotificationRequest>> pending() async {
    await _ensureInitialized();
    return _plugin.pendingNotificationRequests();
  }
}
