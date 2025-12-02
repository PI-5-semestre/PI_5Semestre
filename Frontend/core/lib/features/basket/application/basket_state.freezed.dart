// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BasketState {

 List<BasketModel> get baskets; List<BasketModel> get filtered; String? get filterRole; bool get isLoading; String? get error;
/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BasketStateCopyWith<BasketState> get copyWith => _$BasketStateCopyWithImpl<BasketState>(this as BasketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasketState&&const DeepCollectionEquality().equals(other.baskets, baskets)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(baskets),const DeepCollectionEquality().hash(filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'BasketState(baskets: $baskets, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $BasketStateCopyWith<$Res>  {
  factory $BasketStateCopyWith(BasketState value, $Res Function(BasketState) _then) = _$BasketStateCopyWithImpl;
@useResult
$Res call({
 List<BasketModel> baskets, List<BasketModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class _$BasketStateCopyWithImpl<$Res>
    implements $BasketStateCopyWith<$Res> {
  _$BasketStateCopyWithImpl(this._self, this._then);

  final BasketState _self;
  final $Res Function(BasketState) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baskets = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
baskets: null == baskets ? _self.baskets : baskets // ignore: cast_nullable_to_non_nullable
as List<BasketModel>,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<BasketModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BasketState].
extension BasketStatePatterns on BasketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BasketState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BasketState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BasketState value)  $default,){
final _that = this;
switch (_that) {
case _BasketState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BasketState value)?  $default,){
final _that = this;
switch (_that) {
case _BasketState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BasketModel> baskets,  List<BasketModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BasketState() when $default != null:
return $default(_that.baskets,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BasketModel> baskets,  List<BasketModel> filtered,  String? filterRole,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _BasketState():
return $default(_that.baskets,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BasketModel> baskets,  List<BasketModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _BasketState() when $default != null:
return $default(_that.baskets,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BasketState implements BasketState {
  const _BasketState({final  List<BasketModel> baskets = const [], final  List<BasketModel> filtered = const [], this.filterRole = null, this.isLoading = false, this.error}): _baskets = baskets,_filtered = filtered;
  

 final  List<BasketModel> _baskets;
@override@JsonKey() List<BasketModel> get baskets {
  if (_baskets is EqualUnmodifiableListView) return _baskets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baskets);
}

 final  List<BasketModel> _filtered;
@override@JsonKey() List<BasketModel> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@override@JsonKey() final  String? filterRole;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BasketStateCopyWith<_BasketState> get copyWith => __$BasketStateCopyWithImpl<_BasketState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BasketState&&const DeepCollectionEquality().equals(other._baskets, _baskets)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_baskets),const DeepCollectionEquality().hash(_filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'BasketState(baskets: $baskets, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BasketStateCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$BasketStateCopyWith(_BasketState value, $Res Function(_BasketState) _then) = __$BasketStateCopyWithImpl;
@override @useResult
$Res call({
 List<BasketModel> baskets, List<BasketModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class __$BasketStateCopyWithImpl<$Res>
    implements _$BasketStateCopyWith<$Res> {
  __$BasketStateCopyWithImpl(this._self, this._then);

  final _BasketState _self;
  final $Res Function(_BasketState) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baskets = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_BasketState(
baskets: null == baskets ? _self._baskets : baskets // ignore: cast_nullable_to_non_nullable
as List<BasketModel>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<BasketModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
