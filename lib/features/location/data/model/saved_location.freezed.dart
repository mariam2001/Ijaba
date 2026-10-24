// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedLocation {

 double get latitude; double get longitude;/// The nearest known city (GPS) or the chosen one (manual), for display.
 City? get city;/// Picked from the city list rather than detected by GPS.
 bool get manual;
/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedLocationCopyWith<SavedLocation> get copyWith => _$SavedLocationCopyWithImpl<SavedLocation>(this as SavedLocation, _$identity);

  /// Serializes this SavedLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.city, city) || other.city == city)&&(identical(other.manual, manual) || other.manual == manual));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,city,manual);

@override
String toString() {
  return 'SavedLocation(latitude: $latitude, longitude: $longitude, city: $city, manual: $manual)';
}


}

/// @nodoc
abstract mixin class $SavedLocationCopyWith<$Res>  {
  factory $SavedLocationCopyWith(SavedLocation value, $Res Function(SavedLocation) _then) = _$SavedLocationCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, City? city, bool manual
});


$CityCopyWith<$Res>? get city;

}
/// @nodoc
class _$SavedLocationCopyWithImpl<$Res>
    implements $SavedLocationCopyWith<$Res> {
  _$SavedLocationCopyWithImpl(this._self, this._then);

  final SavedLocation _self;
  final $Res Function(SavedLocation) _then;

/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? city = freezed,Object? manual = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,manual: null == manual ? _self.manual : manual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedLocation].
extension SavedLocationPatterns on SavedLocation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedLocation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedLocation value)  $default,){
final _that = this;
switch (_that) {
case _SavedLocation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedLocation value)?  $default,){
final _that = this;
switch (_that) {
case _SavedLocation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  City? city,  bool manual)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.city,_that.manual);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  City? city,  bool manual)  $default,) {final _that = this;
switch (_that) {
case _SavedLocation():
return $default(_that.latitude,_that.longitude,_that.city,_that.manual);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  City? city,  bool manual)?  $default,) {final _that = this;
switch (_that) {
case _SavedLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.city,_that.manual);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _SavedLocation extends SavedLocation {
  const _SavedLocation({required this.latitude, required this.longitude, this.city, this.manual = false}): super._();
  factory _SavedLocation.fromJson(Map<String, dynamic> json) => _$SavedLocationFromJson(json);

@override final  double latitude;
@override final  double longitude;
/// The nearest known city (GPS) or the chosen one (manual), for display.
@override final  City? city;
/// Picked from the city list rather than detected by GPS.
@override@JsonKey() final  bool manual;

/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedLocationCopyWith<_SavedLocation> get copyWith => __$SavedLocationCopyWithImpl<_SavedLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.city, city) || other.city == city)&&(identical(other.manual, manual) || other.manual == manual));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,city,manual);

@override
String toString() {
  return 'SavedLocation(latitude: $latitude, longitude: $longitude, city: $city, manual: $manual)';
}


}

/// @nodoc
abstract mixin class _$SavedLocationCopyWith<$Res> implements $SavedLocationCopyWith<$Res> {
  factory _$SavedLocationCopyWith(_SavedLocation value, $Res Function(_SavedLocation) _then) = __$SavedLocationCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, City? city, bool manual
});


@override $CityCopyWith<$Res>? get city;

}
/// @nodoc
class __$SavedLocationCopyWithImpl<$Res>
    implements _$SavedLocationCopyWith<$Res> {
  __$SavedLocationCopyWithImpl(this._self, this._then);

  final _SavedLocation _self;
  final $Res Function(_SavedLocation) _then;

/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? city = freezed,Object? manual = null,}) {
  return _then(_SavedLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,manual: null == manual ? _self.manual : manual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SavedLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}

// dart format on
