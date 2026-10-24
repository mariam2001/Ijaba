// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_City _$CityFromJson(Map<String, dynamic> json) => _City(
  nameEn: json['nameEn'] as String,
  nameAr: json['nameAr'] as String,
  countryEn: json['countryEn'] as String,
  countryAr: json['countryAr'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
  'nameEn': instance.nameEn,
  'nameAr': instance.nameAr,
  'countryEn': instance.countryEn,
  'countryAr': instance.countryAr,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
