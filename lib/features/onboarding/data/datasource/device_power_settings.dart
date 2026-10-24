import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The extra battery / auto-launch setting some phone makers add on top of
/// Android. Without it, their battery managers kill scheduled alarms.
class DevicePowerSettings {
  const DevicePowerSettings();

  static final provider = Provider<DevicePowerSettings>(
    (ref) => const DevicePowerSettings(),
  );

  static const _package = 'com.absolutedevs.ijaba';

  /// Brands sharing ColorOS's battery manager (OnePlus moved to it in 2021).
  static const _colorOsBrands = {
    'oppo': 'Oppo',
    'realme': 'realme',
    'oneplus': 'OnePlus',
  };

  /// Older ColorOS (Android 11 and below) kept auto-launch in its security
  /// centre. Not every build exports these, so each is tried in turn.
  static const _legacyColorOsScreens = [
    (
      'com.coloros.safecenter',
      'com.coloros.safecenter.startupapp.StartupAppListActivity',
    ),
    (
      'com.coloros.safecenter',
      'com.coloros.safecenter.permission.startup.StartupAppListActivity',
    ),
    (
      'com.oppo.safe',
      'com.oppo.safe.permission.startup.StartupAppListActivity',
    ),
  ];

  /// "Oppo" when the phone needs the brand-specific step, else null.
  Future<String?> brand() async {
    if (defaultTargetPlatform != TargetPlatform.android) return null;
    final info = await DeviceInfoPlugin().androidInfo;
    return _colorOsBrands[info.manufacturer.toLowerCase()];
  }

  /// Opens the most specific screen available. On current ColorOS that's
  /// the app's own info page (Battery usage → background activity and auto
  /// launch live there).
  Future<void> open() async {
    final info = await DeviceInfoPlugin().androidInfo;
    final colorOs = _colorOsBrands.containsKey(info.manufacturer.toLowerCase());
    if (colorOs && info.version.sdkInt <= 30) {
      for (final (package, activity) in _legacyColorOsScreens) {
        final intent = AndroidIntent(
          package: package,
          componentName: activity,
          flags: const [Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        try {
          if (await intent.canResolveActivity() ?? false) {
            await intent.launch();
            return;
          }
        } on Object catch (error) {
          debugPrint('Could not open $activity: $error');
        }
      }
    }
    await const AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:$_package',
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    ).launch();
  }
}
