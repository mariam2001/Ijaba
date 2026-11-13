// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'window_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WindowConfig {

/// Time from the adhan to the iqama.
 Map<Prayer, Duration> get iqamaDelays;/// Length of the congregational prayer; the after-prayer window opens
/// when it ends (iqama + this).
 Duration get prayerDuration;/// How long the after-prayer window stays open.
 Duration get afterPrayerDuration;
/// Create a copy of WindowConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WindowConfigCopyWith<WindowConfig> get copyWith => _$WindowConfigCopyWithImpl<WindowConfig>(this as WindowConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WindowConfig&&const DeepCollectionEquality().equals(other.iqamaDelays, iqamaDelays)&&(identical(other.prayerDuration, prayerDuration) || other.prayerDuration == prayerDuration)&&(identical(other.afterPrayerDuration, afterPrayerDuration) || other.afterPrayerDuration == afterPrayerDuration));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(iqamaDelays),prayerDuration,afterPrayerDuration);

@override
String toString() {
  return 'WindowConfig(iqamaDelays: $iqamaDelays, prayerDuration: $prayerDuration, afterPrayerDuration: $afterPrayerDuration)';
}


}

/// @nodoc
abstract mixin class $WindowConfigCopyWith<$Res>  {
  factory $WindowConfigCopyWith(WindowConfig value, $Res Function(WindowConfig) _then) = _$WindowConfigCopyWithImpl;
@useResult
$Res call({
 Map<Prayer, Duration> iqamaDelays, Duration prayerDuration, Duration afterPrayerDuration
});




}
/// @nodoc
class _$WindowConfigCopyWithImpl<$Res>
    implements $WindowConfigCopyWith<$Res> {
  _$WindowConfigCopyWithImpl(this._self, this._then);

  final WindowConfig _self;
  final $Res Function(WindowConfig) _then;

/// Create a copy of WindowConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iqamaDelays = null,Object? prayerDuration = null,Object? afterPrayerDuration = null,}) {
  return _then(_self.copyWith(
iqamaDelays: null == iqamaDelays ? _self.iqamaDelays : iqamaDelays // ignore: cast_nullable_to_non_nullable
as Map<Prayer, Duration>,prayerDuration: null == prayerDuration ? _self.prayerDuration : prayerDuration // ignore: cast_nullable_to_non_nullable
as Duration,afterPrayerDuration: null == afterPrayerDuration ? _self.afterPrayerDuration : afterPrayerDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [WindowConfig].
extension WindowConfigPatterns on WindowConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WindowConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WindowConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WindowConfig value)  $default,){
final _that = this;
switch (_that) {
case _WindowConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WindowConfig value)?  $default,){
final _that = this;
switch (_that) {
case _WindowConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<Prayer, Duration> iqamaDelays,  Duration prayerDuration,  Duration afterPrayerDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WindowConfig() when $default != null:
return $default(_that.iqamaDelays,_that.prayerDuration,_that.afterPrayerDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<Prayer, Duration> iqamaDelays,  Duration prayerDuration,  Duration afterPrayerDuration)  $default,) {final _that = this;
switch (_that) {
case _WindowConfig():
return $default(_that.iqamaDelays,_that.prayerDuration,_that.afterPrayerDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<Prayer, Duration> iqamaDelays,  Duration prayerDuration,  Duration afterPrayerDuration)?  $default,) {final _that = this;
switch (_that) {
case _WindowConfig() when $default != null:
return $default(_that.iqamaDelays,_that.prayerDuration,_that.afterPrayerDuration);case _:
  return null;

}
}

}

/// @nodoc


class _WindowConfig extends WindowConfig {
  const _WindowConfig({final  Map<Prayer, Duration> iqamaDelays = const <Prayer, Duration>{Prayer.fajr : Duration(minutes: 20), Prayer.dhuhr : Duration(minutes: 15), Prayer.asr : Duration(minutes: 15), Prayer.maghrib : Duration(minutes: 10), Prayer.isha : Duration(minutes: 15)}, this.prayerDuration = const Duration(minutes: 10), this.afterPrayerDuration = const Duration(minutes: 20)}): _iqamaDelays = iqamaDelays,super._();
  

/// Time from the adhan to the iqama.
 final  Map<Prayer, Duration> _iqamaDelays;
/// Time from the adhan to the iqama.
@override@JsonKey() Map<Prayer, Duration> get iqamaDelays {
  if (_iqamaDelays is EqualUnmodifiableMapView) return _iqamaDelays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_iqamaDelays);
}

/// Length of the congregational prayer; the after-prayer window opens
/// when it ends (iqama + this).
@override@JsonKey() final  Duration prayerDuration;
/// How long the after-prayer window stays open.
@override@JsonKey() final  Duration afterPrayerDuration;

/// Create a copy of WindowConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WindowConfigCopyWith<_WindowConfig> get copyWith => __$WindowConfigCopyWithImpl<_WindowConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WindowConfig&&const DeepCollectionEquality().equals(other._iqamaDelays, _iqamaDelays)&&(identical(other.prayerDuration, prayerDuration) || other.prayerDuration == prayerDuration)&&(identical(other.afterPrayerDuration, afterPrayerDuration) || other.afterPrayerDuration == afterPrayerDuration));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_iqamaDelays),prayerDuration,afterPrayerDuration);

@override
String toString() {
  return 'WindowConfig(iqamaDelays: $iqamaDelays, prayerDuration: $prayerDuration, afterPrayerDuration: $afterPrayerDuration)';
}


}

/// @nodoc
abstract mixin class _$WindowConfigCopyWith<$Res> implements $WindowConfigCopyWith<$Res> {
  factory _$WindowConfigCopyWith(_WindowConfig value, $Res Function(_WindowConfig) _then) = __$WindowConfigCopyWithImpl;
@override @useResult
$Res call({
 Map<Prayer, Duration> iqamaDelays, Duration prayerDuration, Duration afterPrayerDuration
});




}
/// @nodoc
class __$WindowConfigCopyWithImpl<$Res>
    implements _$WindowConfigCopyWith<$Res> {
  __$WindowConfigCopyWithImpl(this._self, this._then);

  final _WindowConfig _self;
  final $Res Function(_WindowConfig) _then;

/// Create a copy of WindowConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iqamaDelays = null,Object? prayerDuration = null,Object? afterPrayerDuration = null,}) {
  return _then(_WindowConfig(
iqamaDelays: null == iqamaDelays ? _self._iqamaDelays : iqamaDelays // ignore: cast_nullable_to_non_nullable
as Map<Prayer, Duration>,prayerDuration: null == prayerDuration ? _self.prayerDuration : prayerDuration // ignore: cast_nullable_to_non_nullable
as Duration,afterPrayerDuration: null == afterPrayerDuration ? _self.afterPrayerDuration : afterPrayerDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
