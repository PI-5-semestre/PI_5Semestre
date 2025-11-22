// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FamilyState {

 List<FamilyModel> get families; List<FamilyModel> get filtered; String? get filterRole; bool get isLoading; String? get error;
/// Create a copy of FamilyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyStateCopyWith<FamilyState> get copyWith => _$FamilyStateCopyWithImpl<FamilyState>(this as FamilyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyState&&const DeepCollectionEquality().equals(other.families, families)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(families),const DeepCollectionEquality().hash(filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'FamilyState(families: $families, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $FamilyStateCopyWith<$Res>  {
  factory $FamilyStateCopyWith(FamilyState value, $Res Function(FamilyState) _then) = _$FamilyStateCopyWithImpl;
@useResult
$Res call({
 List<FamilyModel> families, List<FamilyModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class _$FamilyStateCopyWithImpl<$Res>
    implements $FamilyStateCopyWith<$Res> {
  _$FamilyStateCopyWithImpl(this._self, this._then);

  final FamilyState _self;
  final $Res Function(FamilyState) _then;

/// Create a copy of FamilyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? families = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
families: null == families ? _self.families : families // ignore: cast_nullable_to_non_nullable
as List<FamilyModel>,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<FamilyModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FamilyState].
extension FamilyStatePatterns on FamilyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyState value)  $default,){
final _that = this;
switch (_that) {
case _FamilyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyState value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FamilyModel> families,  List<FamilyModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyState() when $default != null:
return $default(_that.families,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FamilyModel> families,  List<FamilyModel> filtered,  String? filterRole,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _FamilyState():
return $default(_that.families,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FamilyModel> families,  List<FamilyModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _FamilyState() when $default != null:
return $default(_that.families,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _FamilyState implements FamilyState {
  const _FamilyState({final  List<FamilyModel> families = const [], final  List<FamilyModel> filtered = const [], this.filterRole = null, this.isLoading = false, this.error}): _families = families,_filtered = filtered;
  

 final  List<FamilyModel> _families;
@override@JsonKey() List<FamilyModel> get families {
  if (_families is EqualUnmodifiableListView) return _families;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_families);
}

 final  List<FamilyModel> _filtered;
@override@JsonKey() List<FamilyModel> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@override@JsonKey() final  String? filterRole;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of FamilyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyStateCopyWith<_FamilyState> get copyWith => __$FamilyStateCopyWithImpl<_FamilyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyState&&const DeepCollectionEquality().equals(other._families, _families)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_families),const DeepCollectionEquality().hash(_filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'FamilyState(families: $families, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$FamilyStateCopyWith<$Res> implements $FamilyStateCopyWith<$Res> {
  factory _$FamilyStateCopyWith(_FamilyState value, $Res Function(_FamilyState) _then) = __$FamilyStateCopyWithImpl;
@override @useResult
$Res call({
 List<FamilyModel> families, List<FamilyModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class __$FamilyStateCopyWithImpl<$Res>
    implements _$FamilyStateCopyWith<$Res> {
  __$FamilyStateCopyWithImpl(this._self, this._then);

  final _FamilyState _self;
  final $Res Function(_FamilyState) _then;

/// Create a copy of FamilyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? families = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_FamilyState(
families: null == families ? _self._families : families // ignore: cast_nullable_to_non_nullable
as List<FamilyModel>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<FamilyModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
