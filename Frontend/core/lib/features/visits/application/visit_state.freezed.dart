// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VisitState {

 List<Visit> get visities; List<Visit> get filtered; String? get filterRole; bool get isLoading; int? get selectedIndex; String? get error;
/// Create a copy of VisitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitStateCopyWith<VisitState> get copyWith => _$VisitStateCopyWithImpl<VisitState>(this as VisitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitState&&const DeepCollectionEquality().equals(other.visities, visities)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(visities),const DeepCollectionEquality().hash(filtered),filterRole,isLoading,selectedIndex,error);

@override
String toString() {
  return 'VisitState(visities: $visities, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, selectedIndex: $selectedIndex, error: $error)';
}


}

/// @nodoc
abstract mixin class $VisitStateCopyWith<$Res>  {
  factory $VisitStateCopyWith(VisitState value, $Res Function(VisitState) _then) = _$VisitStateCopyWithImpl;
@useResult
$Res call({
 List<Visit> visities, List<Visit> filtered, String? filterRole, bool isLoading, int? selectedIndex, String? error
});




}
/// @nodoc
class _$VisitStateCopyWithImpl<$Res>
    implements $VisitStateCopyWith<$Res> {
  _$VisitStateCopyWithImpl(this._self, this._then);

  final VisitState _self;
  final $Res Function(VisitState) _then;

/// Create a copy of VisitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visities = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? selectedIndex = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
visities: null == visities ? _self.visities : visities // ignore: cast_nullable_to_non_nullable
as List<Visit>,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<Visit>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitState].
extension VisitStatePatterns on VisitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitState value)  $default,){
final _that = this;
switch (_that) {
case _VisitState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitState value)?  $default,){
final _that = this;
switch (_that) {
case _VisitState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Visit> visities,  List<Visit> filtered,  String? filterRole,  bool isLoading,  int? selectedIndex,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitState() when $default != null:
return $default(_that.visities,_that.filtered,_that.filterRole,_that.isLoading,_that.selectedIndex,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Visit> visities,  List<Visit> filtered,  String? filterRole,  bool isLoading,  int? selectedIndex,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VisitState():
return $default(_that.visities,_that.filtered,_that.filterRole,_that.isLoading,_that.selectedIndex,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Visit> visities,  List<Visit> filtered,  String? filterRole,  bool isLoading,  int? selectedIndex,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VisitState() when $default != null:
return $default(_that.visities,_that.filtered,_that.filterRole,_that.isLoading,_that.selectedIndex,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VisitState implements VisitState {
  const _VisitState({final  List<Visit> visities = const [], final  List<Visit> filtered = const [], this.filterRole = null, this.isLoading = false, this.selectedIndex, this.error}): _visities = visities,_filtered = filtered;
  

 final  List<Visit> _visities;
@override@JsonKey() List<Visit> get visities {
  if (_visities is EqualUnmodifiableListView) return _visities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visities);
}

 final  List<Visit> _filtered;
@override@JsonKey() List<Visit> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@override@JsonKey() final  String? filterRole;
@override@JsonKey() final  bool isLoading;
@override final  int? selectedIndex;
@override final  String? error;

/// Create a copy of VisitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitStateCopyWith<_VisitState> get copyWith => __$VisitStateCopyWithImpl<_VisitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitState&&const DeepCollectionEquality().equals(other._visities, _visities)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_visities),const DeepCollectionEquality().hash(_filtered),filterRole,isLoading,selectedIndex,error);

@override
String toString() {
  return 'VisitState(visities: $visities, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, selectedIndex: $selectedIndex, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VisitStateCopyWith<$Res> implements $VisitStateCopyWith<$Res> {
  factory _$VisitStateCopyWith(_VisitState value, $Res Function(_VisitState) _then) = __$VisitStateCopyWithImpl;
@override @useResult
$Res call({
 List<Visit> visities, List<Visit> filtered, String? filterRole, bool isLoading, int? selectedIndex, String? error
});




}
/// @nodoc
class __$VisitStateCopyWithImpl<$Res>
    implements _$VisitStateCopyWith<$Res> {
  __$VisitStateCopyWithImpl(this._self, this._then);

  final _VisitState _self;
  final $Res Function(_VisitState) _then;

/// Create a copy of VisitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visities = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? selectedIndex = freezed,Object? error = freezed,}) {
  return _then(_VisitState(
visities: null == visities ? _self._visities : visities // ignore: cast_nullable_to_non_nullable
as List<Visit>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<Visit>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
