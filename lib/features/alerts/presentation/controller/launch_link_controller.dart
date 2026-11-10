import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/features/alerts/data/datasource/notification_service.dart';
import 'package:ijaba/features/alerts/data/model/alert_payload.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'launch_link_controller.g.dart';

/// Where to go after the splash when the app was launched by tapping an
/// alert: that window's duas. Null for an ordinary launch.
///
/// The splash screen takes it there rather than anything navigating at
/// once: GoRouter may still be settling its initial route, and the splash's
/// own timer would then send the app Home over it.
@Riverpod(keepAlive: true)
Future<String?> launchLink(Ref ref) async {
  final payload = await ref.watch(NotificationService.provider).launchPayload();
  return linkFor(payload);
}

/// An alert tapped while the splash is still showing — on some launches the
/// plugin reports the launching tap this way. The splash follows it.
@Riverpod(keepAlive: true)
class PendingAlertLink extends _$PendingAlertLink {
  @override
  String? build() => null;

  void hold(String link) => state = link;
}

/// The Dua screen of the window [payload]'s alert was for, if any.
String? linkFor(String? payload) {
  final window = AlertPayload.windowToOpen(payload);
  return window == null ? null : AppRoutes.duaFor(window.name);
}
