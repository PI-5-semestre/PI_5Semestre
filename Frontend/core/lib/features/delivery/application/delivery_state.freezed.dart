// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryState {

 List<DeliveryModel> get deliveries; List<DeliveryModel> get filtered; String? get filterRole; bool get isLoading; String? get error;
/// Create a copy of DeliveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryStateCopyWith<DeliveryState> get copyWith => _$DeliveryStateCopyWithImpl<DeliveryState>(this as DeliveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryState&&const DeepCollectionEquality().equals(other.deliveries, deliveries)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(deliveries),const DeepCollectionEquality().hash(filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'DeliveryState(deliveries: $deliveries, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $DeliveryStateCopyWith<$Res>  {
  factory $DeliveryStateCopyWith(DeliveryState value, $Res Function(DeliveryState) _then) = _$DeliveryStateCopyWithImpl;
@useResult
$Res call({
 List<DeliveryModel> deliveries, List<DeliveryModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class _$DeliveryStateCopyWithImpl<$Res>
    implements $DeliveryStateCopyWith<$Res> {
  _$DeliveryStateCopyWithImpl(this._self, this._then);

  final DeliveryState _self;
  final $Res Function(DeliveryState) _then;

/// Create a copy of DeliveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveries = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
deliveries: null == deliveries ? _self.deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryState].
extension DeliveryStatePatterns on DeliveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DeliveryModel> deliveries,  List<DeliveryModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryState() when $default != null:
return $default(_that.deliveries,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DeliveryModel> deliveries,  List<DeliveryModel> filtered,  String? filterRole,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _DeliveryState():
return $default(_that.deliveries,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DeliveryModel> deliveries,  List<DeliveryModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryState() when $default != null:
return $default(_that.deliveries,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryState implements DeliveryState {
  const _DeliveryState({final  List<DeliveryModel> deliveries = const [], final  List<DeliveryModel> filtered = const [], this.filterRole = null, this.isLoading = false, this.error}): _deliveries = deliveries,_filtered = filtered;
  

 final  List<DeliveryModel> _deliveries;
@override@JsonKey() List<DeliveryModel> get deliveries {
  if (_deliveries is EqualUnmodifiableListView) return _deliveries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliveries);
}

 final  List<DeliveryModel> _filtered;
@override@JsonKey() List<DeliveryModel> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@override@JsonKey() final  String? filterRole;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of DeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryStateCopyWith<_DeliveryState> get copyWith => __$DeliveryStateCopyWithImpl<_DeliveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryState&&const DeepCollectionEquality().equals(other._deliveries, _deliveries)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_deliveries),const DeepCollectionEquality().hash(_filtered),filterRole,isLoading,error);

@override
String toString() {
  return 'DeliveryState(deliveries: $deliveries, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DeliveryStateCopyWith<$Res> implements $DeliveryStateCopyWith<$Res> {
  factory _$DeliveryStateCopyWith(_DeliveryState value, $Res Function(_DeliveryState) _then) = __$DeliveryStateCopyWithImpl;
@override @useResult
$Res call({
 List<DeliveryModel> deliveries, List<DeliveryModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class __$DeliveryStateCopyWithImpl<$Res>
    implements _$DeliveryStateCopyWith<$Res> {
  __$DeliveryStateCopyWithImpl(this._self, this._then);

  final _DeliveryState _self;
  final $Res Function(_DeliveryState) _then;

/// Create a copy of DeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveries = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_DeliveryState(
deliveries: null == deliveries ? _self._deliveries : deliveries // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<DeliveryModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
