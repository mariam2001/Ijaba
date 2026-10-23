// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planned_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannedAlert {

/// Minutes since the epoch of [at]: stable, so re-planning reproduces it.
 int get id;/// When to fire, as a UTC instant on a whole minute.
 DateTime get at;/// The windows this alert announces, in [DuaWindowType] order.
 List<DuaWindow> get windows;
/// Create a copy of PlannedAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedAlertCopyWith<PlannedAlert> get copyWith => _$PlannedAlertCopyWithImpl<PlannedAlert>(this as PlannedAlert, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.at, at) || other.at == at)&&const DeepCollectionEquality().equals(other.windows, windows));
}


@override
int get hashCode => Object.hash(runtimeType,id,at,const DeepCollectionEquality().hash(windows));

@override
String toString() {
  return 'PlannedAlert(id: $id, at: $at, windows: $windows)';
}


}

/// @nodoc
abstract mixin class $PlannedAlertCopyWith<$Res>  {
  factory $PlannedAlertCopyWith(PlannedAlert value, $Res Function(PlannedAlert) _then) = _$PlannedAlertCopyWithImpl;
@useResult
$Res call({
 int id, DateTime at, List<DuaWindow> windows
});




}
/// @nodoc
class _$PlannedAlertCopyWithImpl<$Res>
    implements $PlannedAlertCopyWith<$Res> {
  _$PlannedAlertCopyWithImpl(this._self, this._then);

  final PlannedAlert _self;
  final $Res Function(PlannedAlert) _then;

/// Create a copy of PlannedAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? at = null,Object? windows = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindow>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedAlert].
extension PlannedAlertPatterns on PlannedAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedAlert value)  $default,){
final _that = this;
switch (_that) {
case _PlannedAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedAlert value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime at,  List<DuaWindow> windows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedAlert() when $default != null:
return $default(_that.id,_that.at,_that.windows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime at,  List<DuaWindow> windows)  $default,) {final _that = this;
switch (_that) {
case _PlannedAlert():
return $default(_that.id,_that.at,_that.windows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime at,  List<DuaWindow> windows)?  $default,) {final _that = this;
switch (_that) {
case _PlannedAlert() when $default != null:
return $default(_that.id,_that.at,_that.windows);case _:
  return null;

}
}

}

/// @nodoc


class _PlannedAlert extends PlannedAlert {
  const _PlannedAlert({required this.id, required this.at, required final  List<DuaWindow> windows}): _windows = windows,super._();
  

/// Minutes since the epoch of [at]: stable, so re-planning reproduces it.
@override final  int id;
/// When to fire, as a UTC instant on a whole minute.
@override final  DateTime at;
/// The windows this alert announces, in [DuaWindowType] order.
 final  List<DuaWindow> _windows;
/// The windows this alert announces, in [DuaWindowType] order.
@override List<DuaWindow> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}


/// Create a copy of PlannedAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedAlertCopyWith<_PlannedAlert> get copyWith => __$PlannedAlertCopyWithImpl<_PlannedAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.at, at) || other.at == at)&&const DeepCollectionEquality().equals(other._windows, _windows));
}


@override
int get hashCode => Object.hash(runtimeType,id,at,const DeepCollectionEquality().hash(_windows));

@override
String toString() {
  return 'PlannedAlert(id: $id, at: $at, windows: $windows)';
}


}

/// @nodoc
abstract mixin class _$PlannedAlertCopyWith<$Res> implements $PlannedAlertCopyWith<$Res> {
  factory _$PlannedAlertCopyWith(_PlannedAlert value, $Res Function(_PlannedAlert) _then) = __$PlannedAlertCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime at, List<DuaWindow> windows
});




}
/// @nodoc
class __$PlannedAlertCopyWithImpl<$Res>
    implements _$PlannedAlertCopyWith<$Res> {
  __$PlannedAlertCopyWithImpl(this._self, this._then);

  final _PlannedAlert _self;
  final $Res Function(_PlannedAlert) _then;

/// Create a copy of PlannedAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? at = null,Object? windows = null,}) {
  return _then(_PlannedAlert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindow>,
  ));
}


}

// dart format on
