import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_times_controller.g.dart';

/// Where prayer times are calculated. Fixed to Alexandria for the
/// notification test until onboarding (step 4) lets the user choose.
@Riverpod(keepAlive: true)
GeoPoint prayerLocation(Ref ref) =>
    const GeoPoint(latitude: 31.2001, longitude: 29.9187);

/// Calculation settings; defaults until the Settings screen persists them.
@Riverpod(keepAlive: true)
PrayerSettings prayerSettings(Ref ref) => const PrayerSettings();
