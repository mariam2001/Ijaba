// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerSettings {

 CalculationMethod get method; Madhab get madhab;/// Manual correction per prayer, in minutes (Settings → time adjustment).
 Map<Prayer, int> get adjustments;
/// Create a copy of PrayerSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerSettingsCopyWith<PrayerSettings> get copyWith => _$PrayerSettingsCopyWithImpl<PrayerSettings>(this as PrayerSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerSettings&&(identical(other.method, method) || other.method == method)&&(identical(other.madhab, madhab) || other.madhab == madhab)&&const DeepCollectionEquality().equals(other.adjustments, adjustments));
}


@override
int get hashCode => Object.hash(runtimeType,method,madhab,const DeepCollectionEquality().hash(adjustments));

@override
String toString() {
  return 'PrayerSettings(method: $method, madhab: $madhab, adjustments: $adjustments)';
}


}

/// @nodoc
abstract mixin class $PrayerSettingsCopyWith<$Res>  {
  factory $PrayerSettingsCopyWith(PrayerSettings value, $Res Function(PrayerSettings) _then) = _$PrayerSettingsCopyWithImpl;
@useResult
$Res call({
 CalculationMethod method, Madhab madhab, Map<Prayer, int> adjustments
});




}
/// @nodoc
class _$PrayerSettingsCopyWithImpl<$Res>
    implements $PrayerSettingsCopyWith<$Res> {
  _$PrayerSettingsCopyWithImpl(this._self, this._then);

  final PrayerSettings _self;
  final $Res Function(PrayerSettings) _then;

/// Create a copy of PrayerSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? madhab = null,Object? adjustments = null,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CalculationMethod,madhab: null == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab,adjustments: null == adjustments ? _self.adjustments : adjustments // ignore: cast_nullable_to_non_nullable
as Map<Prayer, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerSettings].
extension PrayerSettingsPatterns on PrayerSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerSettings value)  $default,){
final _that = this;
switch (_that) {
case _PrayerSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalculationMethod method,  Madhab madhab,  Map<Prayer, int> adjustments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerSettings() when $default != null:
return $default(_that.method,_that.madhab,_that.adjustments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalculationMethod method,  Madhab madhab,  Map<Prayer, int> adjustments)  $default,) {final _that = this;
switch (_that) {
case _PrayerSettings():
return $default(_that.method,_that.madhab,_that.adjustments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalculationMethod method,  Madhab madhab,  Map<Prayer, int> adjustments)?  $default,) {final _that = this;
switch (_that) {
case _PrayerSettings() when $default != null:
return $default(_that.method,_that.madhab,_that.adjustments);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerSettings implements PrayerSettings {
  const _PrayerSettings({this.method = CalculationMethod.egyptian, this.madhab = Madhab.shafi, final  Map<Prayer, int> adjustments = const <Prayer, int>{}}): _adjustments = adjustments;
  

@override@JsonKey() final  CalculationMethod method;
@override@JsonKey() final  Madhab madhab;
/// Manual correction per prayer, in minutes (Settings → time adjustment).
 final  Map<Prayer, int> _adjustments;
/// Manual correction per prayer, in minutes (Settings → time adjustment).
@override@JsonKey() Map<Prayer, int> get adjustments {
  if (_adjustments is EqualUnmodifiableMapView) return _adjustments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_adjustments);
}


/// Create a copy of PrayerSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerSettingsCopyWith<_PrayerSettings> get copyWith => __$PrayerSettingsCopyWithImpl<_PrayerSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerSettings&&(identical(other.method, method) || other.method == method)&&(identical(other.madhab, madhab) || other.madhab == madhab)&&const DeepCollectionEquality().equals(other._adjustments, _adjustments));
}


@override
int get hashCode => Object.hash(runtimeType,method,madhab,const DeepCollectionEquality().hash(_adjustments));

@override
String toString() {
  return 'PrayerSettings(method: $method, madhab: $madhab, adjustments: $adjustments)';
}


}

/// @nodoc
abstract mixin class _$PrayerSettingsCopyWith<$Res> implements $PrayerSettingsCopyWith<$Res> {
  factory _$PrayerSettingsCopyWith(_PrayerSettings value, $Res Function(_PrayerSettings) _then) = __$PrayerSettingsCopyWithImpl;
@override @useResult
$Res call({
 CalculationMethod method, Madhab madhab, Map<Prayer, int> adjustments
});




}
/// @nodoc
class __$PrayerSettingsCopyWithImpl<$Res>
    implements _$PrayerSettingsCopyWith<$Res> {
  __$PrayerSettingsCopyWithImpl(this._self, this._then);

  final _PrayerSettings _self;
  final $Res Function(_PrayerSettings) _then;

/// Create a copy of PrayerSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? madhab = null,Object? adjustments = null,}) {
  return _then(_PrayerSettings(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CalculationMethod,madhab: null == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab,adjustments: null == adjustments ? _self._adjustments : adjustments // ignore: cast_nullable_to_non_nullable
as Map<Prayer, int>,
  ));
}


}

// dart format on
