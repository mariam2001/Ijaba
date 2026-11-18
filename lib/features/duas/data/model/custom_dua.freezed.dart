// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_dua.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomDua {

 String get id; String get text; List<DuaWindowType> get windows;
/// Create a copy of CustomDua
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomDuaCopyWith<CustomDua> get copyWith => _$CustomDuaCopyWithImpl<CustomDua>(this as CustomDua, _$identity);

  /// Serializes this CustomDua to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomDua&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.windows, windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,const DeepCollectionEquality().hash(windows));

@override
String toString() {
  return 'CustomDua(id: $id, text: $text, windows: $windows)';
}


}

/// @nodoc
abstract mixin class $CustomDuaCopyWith<$Res>  {
  factory $CustomDuaCopyWith(CustomDua value, $Res Function(CustomDua) _then) = _$CustomDuaCopyWithImpl;
@useResult
$Res call({
 String id, String text, List<DuaWindowType> windows
});




}
/// @nodoc
class _$CustomDuaCopyWithImpl<$Res>
    implements $CustomDuaCopyWith<$Res> {
  _$CustomDuaCopyWithImpl(this._self, this._then);

  final CustomDua _self;
  final $Res Function(CustomDua) _then;

/// Create a copy of CustomDua
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? windows = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindowType>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomDua].
extension CustomDuaPatterns on CustomDua {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomDua value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomDua() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomDua value)  $default,){
final _that = this;
switch (_that) {
case _CustomDua():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomDua value)?  $default,){
final _that = this;
switch (_that) {
case _CustomDua() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  List<DuaWindowType> windows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomDua() when $default != null:
return $default(_that.id,_that.text,_that.windows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  List<DuaWindowType> windows)  $default,) {final _that = this;
switch (_that) {
case _CustomDua():
return $default(_that.id,_that.text,_that.windows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  List<DuaWindowType> windows)?  $default,) {final _that = this;
switch (_that) {
case _CustomDua() when $default != null:
return $default(_that.id,_that.text,_that.windows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomDua extends CustomDua {
  const _CustomDua({required this.id, required this.text, final  List<DuaWindowType> windows = const []}): _windows = windows,super._();
  factory _CustomDua.fromJson(Map<String, dynamic> json) => _$CustomDuaFromJson(json);

@override final  String id;
@override final  String text;
 final  List<DuaWindowType> _windows;
@override@JsonKey() List<DuaWindowType> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}


/// Create a copy of CustomDua
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomDuaCopyWith<_CustomDua> get copyWith => __$CustomDuaCopyWithImpl<_CustomDua>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomDuaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomDua&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._windows, _windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,const DeepCollectionEquality().hash(_windows));

@override
String toString() {
  return 'CustomDua(id: $id, text: $text, windows: $windows)';
}


}

/// @nodoc
abstract mixin class _$CustomDuaCopyWith<$Res> implements $CustomDuaCopyWith<$Res> {
  factory _$CustomDuaCopyWith(_CustomDua value, $Res Function(_CustomDua) _then) = __$CustomDuaCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, List<DuaWindowType> windows
});




}
/// @nodoc
class __$CustomDuaCopyWithImpl<$Res>
    implements _$CustomDuaCopyWith<$Res> {
  __$CustomDuaCopyWithImpl(this._self, this._then);

  final _CustomDua _self;
  final $Res Function(_CustomDua) _then;

/// Create a copy of CustomDua
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? windows = null,}) {
  return _then(_CustomDua(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindowType>,
  ));
}


}

// dart format on
