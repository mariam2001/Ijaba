// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dua_window.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DuaWindow {

 DuaWindowType get type; DateTime get start; DateTime get end;/// The prayer the window belongs to (adhan-to-iqama and after-prayer).
 Prayer? get prayer;
/// Create a copy of DuaWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuaWindowCopyWith<DuaWindow> get copyWith => _$DuaWindowCopyWithImpl<DuaWindow>(this as DuaWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuaWindow&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.prayer, prayer) || other.prayer == prayer));
}


@override
int get hashCode => Object.hash(runtimeType,type,start,end,prayer);

@override
String toString() {
  return 'DuaWindow(type: $type, start: $start, end: $end, prayer: $prayer)';
}


}

/// @nodoc
abstract mixin class $DuaWindowCopyWith<$Res>  {
  factory $DuaWindowCopyWith(DuaWindow value, $Res Function(DuaWindow) _then) = _$DuaWindowCopyWithImpl;
@useResult
$Res call({
 DuaWindowType type, DateTime start, DateTime end, Prayer? prayer
});




}
/// @nodoc
class _$DuaWindowCopyWithImpl<$Res>
    implements $DuaWindowCopyWith<$Res> {
  _$DuaWindowCopyWithImpl(this._self, this._then);

  final DuaWindow _self;
  final $Res Function(DuaWindow) _then;

/// Create a copy of DuaWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? start = null,Object? end = null,Object? prayer = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DuaWindowType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,prayer: freezed == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as Prayer?,
  ));
}

}


/// Adds pattern-matching-related methods to [DuaWindow].
extension DuaWindowPatterns on DuaWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DuaWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DuaWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DuaWindow value)  $default,){
final _that = this;
switch (_that) {
case _DuaWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DuaWindow value)?  $default,){
final _that = this;
switch (_that) {
case _DuaWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DuaWindowType type,  DateTime start,  DateTime end,  Prayer? prayer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DuaWindow() when $default != null:
return $default(_that.type,_that.start,_that.end,_that.prayer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DuaWindowType type,  DateTime start,  DateTime end,  Prayer? prayer)  $default,) {final _that = this;
switch (_that) {
case _DuaWindow():
return $default(_that.type,_that.start,_that.end,_that.prayer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DuaWindowType type,  DateTime start,  DateTime end,  Prayer? prayer)?  $default,) {final _that = this;
switch (_that) {
case _DuaWindow() when $default != null:
return $default(_that.type,_that.start,_that.end,_that.prayer);case _:
  return null;

}
}

}

/// @nodoc


class _DuaWindow extends DuaWindow {
  const _DuaWindow({required this.type, required this.start, required this.end, this.prayer}): super._();
  

@override final  DuaWindowType type;
@override final  DateTime start;
@override final  DateTime end;
/// The prayer the window belongs to (adhan-to-iqama and after-prayer).
@override final  Prayer? prayer;

/// Create a copy of DuaWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuaWindowCopyWith<_DuaWindow> get copyWith => __$DuaWindowCopyWithImpl<_DuaWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DuaWindow&&(identical(other.type, type) || other.type == type)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.prayer, prayer) || other.prayer == prayer));
}


@override
int get hashCode => Object.hash(runtimeType,type,start,end,prayer);

@override
String toString() {
  return 'DuaWindow(type: $type, start: $start, end: $end, prayer: $prayer)';
}


}

/// @nodoc
abstract mixin class _$DuaWindowCopyWith<$Res> implements $DuaWindowCopyWith<$Res> {
  factory _$DuaWindowCopyWith(_DuaWindow value, $Res Function(_DuaWindow) _then) = __$DuaWindowCopyWithImpl;
@override @useResult
$Res call({
 DuaWindowType type, DateTime start, DateTime end, Prayer? prayer
});




}
/// @nodoc
class __$DuaWindowCopyWithImpl<$Res>
    implements _$DuaWindowCopyWith<$Res> {
  __$DuaWindowCopyWithImpl(this._self, this._then);

  final _DuaWindow _self;
  final $Res Function(_DuaWindow) _then;

/// Create a copy of DuaWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? start = null,Object? end = null,Object? prayer = freezed,}) {
  return _then(_DuaWindow(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DuaWindowType,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,prayer: freezed == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as Prayer?,
  ));
}


}

// dart format on
