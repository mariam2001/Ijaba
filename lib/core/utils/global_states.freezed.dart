// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalStates<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalStates<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalStates<$T>()';
}


}

/// @nodoc
class $GlobalStatesCopyWith<T,$Res>  {
$GlobalStatesCopyWith(GlobalStates<T> _, $Res Function(GlobalStates<T>) __);
}


/// Adds pattern-matching-related methods to [GlobalStates].
extension GlobalStatesPatterns<T> on GlobalStates<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GlobalStatesInitial<T> value)?  initial,TResult Function( GlobalStatesLoading<T> value)?  loading,TResult Function( GlobalStatesSuccess<T> value)?  success,TResult Function( GlobalStatesFail<T> value)?  fail,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GlobalStatesInitial() when initial != null:
return initial(_that);case GlobalStatesLoading() when loading != null:
return loading(_that);case GlobalStatesSuccess() when success != null:
return success(_that);case GlobalStatesFail() when fail != null:
return fail(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GlobalStatesInitial<T> value)  initial,required TResult Function( GlobalStatesLoading<T> value)  loading,required TResult Function( GlobalStatesSuccess<T> value)  success,required TResult Function( GlobalStatesFail<T> value)  fail,}){
final _that = this;
switch (_that) {
case GlobalStatesInitial():
return initial(_that);case GlobalStatesLoading():
return loading(_that);case GlobalStatesSuccess():
return success(_that);case GlobalStatesFail():
return fail(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GlobalStatesInitial<T> value)?  initial,TResult? Function( GlobalStatesLoading<T> value)?  loading,TResult? Function( GlobalStatesSuccess<T> value)?  success,TResult? Function( GlobalStatesFail<T> value)?  fail,}){
final _that = this;
switch (_that) {
case GlobalStatesInitial() when initial != null:
return initial(_that);case GlobalStatesLoading() when loading != null:
return loading(_that);case GlobalStatesSuccess() when success != null:
return success(_that);case GlobalStatesFail() when fail != null:
return fail(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T data)?  success,TResult Function( String message)?  fail,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GlobalStatesInitial() when initial != null:
return initial();case GlobalStatesLoading() when loading != null:
return loading();case GlobalStatesSuccess() when success != null:
return success(_that.data);case GlobalStatesFail() when fail != null:
return fail(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T data)  success,required TResult Function( String message)  fail,}) {final _that = this;
switch (_that) {
case GlobalStatesInitial():
return initial();case GlobalStatesLoading():
return loading();case GlobalStatesSuccess():
return success(_that.data);case GlobalStatesFail():
return fail(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T data)?  success,TResult? Function( String message)?  fail,}) {final _that = this;
switch (_that) {
case GlobalStatesInitial() when initial != null:
return initial();case GlobalStatesLoading() when loading != null:
return loading();case GlobalStatesSuccess() when success != null:
return success(_that.data);case GlobalStatesFail() when fail != null:
return fail(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class GlobalStatesInitial<T> extends GlobalStates<T> {
  const GlobalStatesInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalStatesInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalStates<$T>.initial()';
}


}




/// @nodoc


class GlobalStatesLoading<T> extends GlobalStates<T> {
  const GlobalStatesLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalStatesLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalStates<$T>.loading()';
}


}




/// @nodoc


class GlobalStatesSuccess<T> extends GlobalStates<T> {
  const GlobalStatesSuccess(this.data): super._();
  

 final  T data;

/// Create a copy of GlobalStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalStatesSuccessCopyWith<T, GlobalStatesSuccess<T>> get copyWith => _$GlobalStatesSuccessCopyWithImpl<T, GlobalStatesSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalStatesSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'GlobalStates<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $GlobalStatesSuccessCopyWith<T,$Res> implements $GlobalStatesCopyWith<T, $Res> {
  factory $GlobalStatesSuccessCopyWith(GlobalStatesSuccess<T> value, $Res Function(GlobalStatesSuccess<T>) _then) = _$GlobalStatesSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$GlobalStatesSuccessCopyWithImpl<T,$Res>
    implements $GlobalStatesSuccessCopyWith<T, $Res> {
  _$GlobalStatesSuccessCopyWithImpl(this._self, this._then);

  final GlobalStatesSuccess<T> _self;
  final $Res Function(GlobalStatesSuccess<T>) _then;

/// Create a copy of GlobalStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(GlobalStatesSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class GlobalStatesFail<T> extends GlobalStates<T> {
  const GlobalStatesFail(this.message): super._();
  

 final  String message;

/// Create a copy of GlobalStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalStatesFailCopyWith<T, GlobalStatesFail<T>> get copyWith => _$GlobalStatesFailCopyWithImpl<T, GlobalStatesFail<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalStatesFail<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GlobalStates<$T>.fail(message: $message)';
}


}

/// @nodoc
abstract mixin class $GlobalStatesFailCopyWith<T,$Res> implements $GlobalStatesCopyWith<T, $Res> {
  factory $GlobalStatesFailCopyWith(GlobalStatesFail<T> value, $Res Function(GlobalStatesFail<T>) _then) = _$GlobalStatesFailCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GlobalStatesFailCopyWithImpl<T,$Res>
    implements $GlobalStatesFailCopyWith<T, $Res> {
  _$GlobalStatesFailCopyWithImpl(this._self, this._then);

  final GlobalStatesFail<T> _self;
  final $Res Function(GlobalStatesFail<T>) _then;

/// Create a copy of GlobalStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GlobalStatesFail<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
