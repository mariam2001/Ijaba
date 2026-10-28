// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dua.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dua {

 String get id; String get arabic;/// Simple Latin spelling, shown in English mode.
 String get transliteration;/// By language code: "ar" (a plain-Arabic rendering) and "en".
 Map<String, String> get meaning;/// The attribution, by language code. Shown with a "verify" flag until
/// [verified] — Mariam checks every source before release.
 Map<String, String> get source; bool get verified;/// Times to repeat it (the tasbih counter's target).
 int get repeat;/// Windows it belongs to; none means any window.
 List<DuaWindowType> get windows;
/// Create a copy of Dua
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuaCopyWith<Dua> get copyWith => _$DuaCopyWithImpl<Dua>(this as Dua, _$identity);

  /// Serializes this Dua to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dua&&(identical(other.id, id) || other.id == id)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&const DeepCollectionEquality().equals(other.meaning, meaning)&&const DeepCollectionEquality().equals(other.source, source)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other.windows, windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,arabic,transliteration,const DeepCollectionEquality().hash(meaning),const DeepCollectionEquality().hash(source),verified,repeat,const DeepCollectionEquality().hash(windows));

@override
String toString() {
  return 'Dua(id: $id, arabic: $arabic, transliteration: $transliteration, meaning: $meaning, source: $source, verified: $verified, repeat: $repeat, windows: $windows)';
}


}

/// @nodoc
abstract mixin class $DuaCopyWith<$Res>  {
  factory $DuaCopyWith(Dua value, $Res Function(Dua) _then) = _$DuaCopyWithImpl;
@useResult
$Res call({
 String id, String arabic, String transliteration, Map<String, String> meaning, Map<String, String> source, bool verified, int repeat, List<DuaWindowType> windows
});




}
/// @nodoc
class _$DuaCopyWithImpl<$Res>
    implements $DuaCopyWith<$Res> {
  _$DuaCopyWithImpl(this._self, this._then);

  final Dua _self;
  final $Res Function(Dua) _then;

/// Create a copy of Dua
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? arabic = null,Object? transliteration = null,Object? meaning = null,Object? source = null,Object? verified = null,Object? repeat = null,Object? windows = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as Map<String, String>,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as Map<String, String>,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindowType>,
  ));
}

}


/// Adds pattern-matching-related methods to [Dua].
extension DuaPatterns on Dua {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dua value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dua() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dua value)  $default,){
final _that = this;
switch (_that) {
case _Dua():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dua value)?  $default,){
final _that = this;
switch (_that) {
case _Dua() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String arabic,  String transliteration,  Map<String, String> meaning,  Map<String, String> source,  bool verified,  int repeat,  List<DuaWindowType> windows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dua() when $default != null:
return $default(_that.id,_that.arabic,_that.transliteration,_that.meaning,_that.source,_that.verified,_that.repeat,_that.windows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String arabic,  String transliteration,  Map<String, String> meaning,  Map<String, String> source,  bool verified,  int repeat,  List<DuaWindowType> windows)  $default,) {final _that = this;
switch (_that) {
case _Dua():
return $default(_that.id,_that.arabic,_that.transliteration,_that.meaning,_that.source,_that.verified,_that.repeat,_that.windows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String arabic,  String transliteration,  Map<String, String> meaning,  Map<String, String> source,  bool verified,  int repeat,  List<DuaWindowType> windows)?  $default,) {final _that = this;
switch (_that) {
case _Dua() when $default != null:
return $default(_that.id,_that.arabic,_that.transliteration,_that.meaning,_that.source,_that.verified,_that.repeat,_that.windows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Dua extends Dua {
  const _Dua({required this.id, required this.arabic, required this.transliteration, required final  Map<String, String> meaning, final  Map<String, String> source = const {}, this.verified = false, this.repeat = 1, final  List<DuaWindowType> windows = const []}): _meaning = meaning,_source = source,_windows = windows,super._();
  factory _Dua.fromJson(Map<String, dynamic> json) => _$DuaFromJson(json);

@override final  String id;
@override final  String arabic;
/// Simple Latin spelling, shown in English mode.
@override final  String transliteration;
/// By language code: "ar" (a plain-Arabic rendering) and "en".
 final  Map<String, String> _meaning;
/// By language code: "ar" (a plain-Arabic rendering) and "en".
@override Map<String, String> get meaning {
  if (_meaning is EqualUnmodifiableMapView) return _meaning;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_meaning);
}

/// The attribution, by language code. Shown with a "verify" flag until
/// [verified] — Mariam checks every source before release.
 final  Map<String, String> _source;
/// The attribution, by language code. Shown with a "verify" flag until
/// [verified] — Mariam checks every source before release.
@override@JsonKey() Map<String, String> get source {
  if (_source is EqualUnmodifiableMapView) return _source;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_source);
}

@override@JsonKey() final  bool verified;
/// Times to repeat it (the tasbih counter's target).
@override@JsonKey() final  int repeat;
/// Windows it belongs to; none means any window.
 final  List<DuaWindowType> _windows;
/// Windows it belongs to; none means any window.
@override@JsonKey() List<DuaWindowType> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}


/// Create a copy of Dua
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuaCopyWith<_Dua> get copyWith => __$DuaCopyWithImpl<_Dua>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DuaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dua&&(identical(other.id, id) || other.id == id)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&const DeepCollectionEquality().equals(other._meaning, _meaning)&&const DeepCollectionEquality().equals(other._source, _source)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other._windows, _windows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,arabic,transliteration,const DeepCollectionEquality().hash(_meaning),const DeepCollectionEquality().hash(_source),verified,repeat,const DeepCollectionEquality().hash(_windows));

@override
String toString() {
  return 'Dua(id: $id, arabic: $arabic, transliteration: $transliteration, meaning: $meaning, source: $source, verified: $verified, repeat: $repeat, windows: $windows)';
}


}

/// @nodoc
abstract mixin class _$DuaCopyWith<$Res> implements $DuaCopyWith<$Res> {
  factory _$DuaCopyWith(_Dua value, $Res Function(_Dua) _then) = __$DuaCopyWithImpl;
@override @useResult
$Res call({
 String id, String arabic, String transliteration, Map<String, String> meaning, Map<String, String> source, bool verified, int repeat, List<DuaWindowType> windows
});




}
/// @nodoc
class __$DuaCopyWithImpl<$Res>
    implements _$DuaCopyWith<$Res> {
  __$DuaCopyWithImpl(this._self, this._then);

  final _Dua _self;
  final $Res Function(_Dua) _then;

/// Create a copy of Dua
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? arabic = null,Object? transliteration = null,Object? meaning = null,Object? source = null,Object? verified = null,Object? repeat = null,Object? windows = null,}) {
  return _then(_Dua(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self._meaning : meaning // ignore: cast_nullable_to_non_nullable
as Map<String, String>,source: null == source ? _self._source : source // ignore: cast_nullable_to_non_nullable
as Map<String, String>,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<DuaWindowType>,
  ));
}


}

// dart format on
