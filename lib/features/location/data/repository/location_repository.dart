import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/core/error/guard.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/data/datasource/city_directory.dart';
import 'package:ijaba/features/location/data/datasource/location_service.dart';
import 'package:ijaba/features/location/data/model/saved_location.dart';

class LocationRepository {
  const LocationRepository(this._ref);

  static final provider = Provider<LocationRepository>(LocationRepository.new);

  final Ref _ref;

  /// GPS position labelled with the nearest bundled city — no network.
  FutureEither<SavedLocation> detect() => guard(() async {
    final point = await _ref.read(LocationService.provider).currentPosition();
    final cities = await _ref.read(cityDirectoryProvider.future);
    return SavedLocation(
      latitude: point.latitude,
      longitude: point.longitude,
      city: cities.nearest(point),
    );
  });
}
