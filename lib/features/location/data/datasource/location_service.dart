import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Reads the device position. City-level ("coarse") accuracy is all prayer
/// times need, and is the less invasive permission.
class LocationService {
  const LocationService();

  static final provider = Provider<LocationService>(
    (ref) => const LocationService(),
  );

  Future<bool> hasPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Asks for permission if needed, then reads the position. Throws a
  /// [LocationFailure] with a user-facing message when it can't.
  Future<GeoPoint> currentPosition() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationFailure(LocaleKeys.errors_location_denied.tr());
    }
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw LocationFailure(LocaleKeys.errors_location_off.tr());
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 20),
        ),
      );
      return GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on TimeoutException {
      final last = await Geolocator.getLastKnownPosition();
      if (last == null) {
        throw LocationFailure(LocaleKeys.errors_location_unavailable.tr());
      }
      return GeoPoint(latitude: last.latitude, longitude: last.longitude);
    }
  }
}
