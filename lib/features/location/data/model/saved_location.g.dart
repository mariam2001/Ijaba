// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedLocation _$SavedLocationFromJson(Map<String, dynamic> json) =>
    _SavedLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      manual: json['manual'] as bool? ?? false,
    );

Map<String, dynamic> _$SavedLocationToJson(_SavedLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': ?instance.city?.toJson(),
      'manual': instance.manual,
    };
