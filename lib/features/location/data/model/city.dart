import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ijaba/core/utils/typedef.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
abstract class City with _$City {
  const City._();

  const factory City({
    required String nameEn,
    required String nameAr,
    required String countryEn,
    required String countryAr,
    required double latitude,
    required double longitude,
  }) = _City;

  factory City.fromJson(Json json) => _$CityFromJson(json);

  /// "الإسكندرية، مصر" / "Alexandria, Egypt".
  String label({required bool arabic}) =>
      arabic ? '$nameAr، $countryAr' : '$nameEn, $countryEn';
}
