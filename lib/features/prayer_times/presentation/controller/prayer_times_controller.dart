import 'package:ijaba/features/location/presentation/controller/location_controller.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_times_controller.g.dart';

/// Where prayer times are calculated; null until onboarding saves a location.
@Riverpod(keepAlive: true)
GeoPoint? prayerLocation(Ref ref) =>
    ref.watch(locationControllerProvider)?.point;

/// Calculation settings; defaults until the Settings screen persists them.
@Riverpod(keepAlive: true)
PrayerSettings prayerSettings(Ref ref) => const PrayerSettings();
