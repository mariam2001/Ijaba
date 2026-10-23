// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerDay {

/// The calendar day, as a UTC midnight (only the date part is meaningful).
 DateTime get date; DateTime get fajr; DateTime get sunrise; DateTime get dhuhr; DateTime get asr; DateTime get maghrib; DateTime get isha;/// Fajr of the following day, which ends this day's night.
 DateTime get nextFajr;
/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerDayCopyWith<PrayerDay> get copyWith => _$PrayerDayCopyWithImpl<PrayerDay>(this as PrayerDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerDay&&(identical(other.date, date) || other.date == date)&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.nextFajr, nextFajr) || other.nextFajr == nextFajr));
}


@override
int get hashCode => Object.hash(runtimeType,date,fajr,sunrise,dhuhr,asr,maghrib,isha,nextFajr);

@override
String toString() {
  return 'PrayerDay(date: $date, fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, nextFajr: $nextFajr)';
}


}

/// @nodoc
abstract mixin class $PrayerDayCopyWith<$Res>  {
  factory $PrayerDayCopyWith(PrayerDay value, $Res Function(PrayerDay) _then) = _$PrayerDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, DateTime fajr, DateTime sunrise, DateTime dhuhr, DateTime asr, DateTime maghrib, DateTime isha, DateTime nextFajr
});




}
/// @nodoc
class _$PrayerDayCopyWithImpl<$Res>
    implements $PrayerDayCopyWith<$Res> {
  _$PrayerDayCopyWithImpl(this._self, this._then);

  final PrayerDay _self;
  final $Res Function(PrayerDay) _then;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? nextFajr = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as DateTime,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as DateTime,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as DateTime,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as DateTime,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as DateTime,nextFajr: null == nextFajr ? _self.nextFajr : nextFajr // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerDay].
extension PrayerDayPatterns on PrayerDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerDay value)  $default,){
final _that = this;
switch (_that) {
case _PrayerDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerDay value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  DateTime nextFajr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextFajr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  DateTime nextFajr)  $default,) {final _that = this;
switch (_that) {
case _PrayerDay():
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextFajr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  DateTime nextFajr)?  $default,) {final _that = this;
switch (_that) {
case _PrayerDay() when $default != null:
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextFajr);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerDay extends PrayerDay {
  const _PrayerDay({required this.date, required this.fajr, required this.sunrise, required this.dhuhr, required this.asr, required this.maghrib, required this.isha, required this.nextFajr}): super._();
  

/// The calendar day, as a UTC midnight (only the date part is meaningful).
@override final  DateTime date;
@override final  DateTime fajr;
@override final  DateTime sunrise;
@override final  DateTime dhuhr;
@override final  DateTime asr;
@override final  DateTime maghrib;
@override final  DateTime isha;
/// Fajr of the following day, which ends this day's night.
@override final  DateTime nextFajr;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerDayCopyWith<_PrayerDay> get copyWith => __$PrayerDayCopyWithImpl<_PrayerDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerDay&&(identical(other.date, date) || other.date == date)&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.nextFajr, nextFajr) || other.nextFajr == nextFajr));
}


@override
int get hashCode => Object.hash(runtimeType,date,fajr,sunrise,dhuhr,asr,maghrib,isha,nextFajr);

@override
String toString() {
  return 'PrayerDay(date: $date, fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, nextFajr: $nextFajr)';
}


}

/// @nodoc
abstract mixin class _$PrayerDayCopyWith<$Res> implements $PrayerDayCopyWith<$Res> {
  factory _$PrayerDayCopyWith(_PrayerDay value, $Res Function(_PrayerDay) _then) = __$PrayerDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, DateTime fajr, DateTime sunrise, DateTime dhuhr, DateTime asr, DateTime maghrib, DateTime isha, DateTime nextFajr
});




}
/// @nodoc
class __$PrayerDayCopyWithImpl<$Res>
    implements _$PrayerDayCopyWith<$Res> {
  __$PrayerDayCopyWithImpl(this._self, this._then);

  final _PrayerDay _self;
  final $Res Function(_PrayerDay) _then;

/// Create a copy of PrayerDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? nextFajr = null,}) {
  return _then(_PrayerDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as DateTime,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as DateTime,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as DateTime,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as DateTime,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as DateTime,nextFajr: null == nextFajr ? _self.nextFajr : nextFajr // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
