import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/features/location/data/model/city.dart';
import 'package:ijaba/features/prayer_times/data/model/geo_point.dart';

part 'saved_location.freezed.dart';
part 'saved_location.g.dart';

/// Where prayer times are calculated, as stored on the device.
@freezed
abstract class SavedLocation with _$SavedLocation {
  const SavedLocation._();

  // explicitToJson: serialise the nested City as a map, not an object.
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory SavedLocation({
    required double latitude,
    required double longitude,

    /// The nearest known city (GPS) or the chosen one (manual), for display.
    City? city,

    /// Picked from the city list rather than detected by GPS.
    @Default(false) bool manual,
  }) = _SavedLocation;

  factory SavedLocation.fromJson(Json json) => _$SavedLocationFromJson(json);

  factory SavedLocation.ofCity(City city) => SavedLocation(
    latitude: city.latitude,
    longitude: city.longitude,
    city: city,
    manual: true,
  );

  GeoPoint get point => GeoPoint(latitude: latitude, longitude: longitude);
}
