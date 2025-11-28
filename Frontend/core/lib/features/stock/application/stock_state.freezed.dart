// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockState implements DiagnosticableTreeMixin {

 List<StockModel> get stocks; List<StockModel> get filtered; String? get filterRole; bool get isLoading; String? get error;
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockStateCopyWith<StockState> get copyWith => _$StockStateCopyWithImpl<StockState>(this as StockState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StockState'))
    ..add(DiagnosticsProperty('stocks', stocks))..add(DiagnosticsProperty('filtered', filtered))..add(DiagnosticsProperty('filterRole', filterRole))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockState&&const DeepCollectionEquality().equals(other.stocks, stocks)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stocks),const DeepCollectionEquality().hash(filtered),filterRole,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StockState(stocks: $stocks, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $StockStateCopyWith<$Res>  {
  factory $StockStateCopyWith(StockState value, $Res Function(StockState) _then) = _$StockStateCopyWithImpl;
@useResult
$Res call({
 List<StockModel> stocks, List<StockModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class _$StockStateCopyWithImpl<$Res>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._self, this._then);

  final StockState _self;
  final $Res Function(StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stocks = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<StockModel>,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<StockModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockState].
extension StockStatePatterns on StockState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockState value)  $default,){
final _that = this;
switch (_that) {
case _StockState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockState value)?  $default,){
final _that = this;
switch (_that) {
case _StockState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockModel> stocks,  List<StockModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stocks,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockModel> stocks,  List<StockModel> filtered,  String? filterRole,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _StockState():
return $default(_that.stocks,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockModel> stocks,  List<StockModel> filtered,  String? filterRole,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _StockState() when $default != null:
return $default(_that.stocks,_that.filtered,_that.filterRole,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _StockState with DiagnosticableTreeMixin implements StockState {
  const _StockState({final  List<StockModel> stocks = const [], final  List<StockModel> filtered = const [], this.filterRole = null, this.isLoading = false, this.error}): _stocks = stocks,_filtered = filtered;
  

 final  List<StockModel> _stocks;
@override@JsonKey() List<StockModel> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

 final  List<StockModel> _filtered;
@override@JsonKey() List<StockModel> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@override@JsonKey() final  String? filterRole;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockStateCopyWith<_StockState> get copyWith => __$StockStateCopyWithImpl<_StockState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StockState'))
    ..add(DiagnosticsProperty('stocks', stocks))..add(DiagnosticsProperty('filtered', filtered))..add(DiagnosticsProperty('filterRole', filterRole))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockState&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.filterRole, filterRole) || other.filterRole == filterRole)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stocks),const DeepCollectionEquality().hash(_filtered),filterRole,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StockState(stocks: $stocks, filtered: $filtered, filterRole: $filterRole, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$StockStateCopyWith<$Res> implements $StockStateCopyWith<$Res> {
  factory _$StockStateCopyWith(_StockState value, $Res Function(_StockState) _then) = __$StockStateCopyWithImpl;
@override @useResult
$Res call({
 List<StockModel> stocks, List<StockModel> filtered, String? filterRole, bool isLoading, String? error
});




}
/// @nodoc
class __$StockStateCopyWithImpl<$Res>
    implements _$StockStateCopyWith<$Res> {
  __$StockStateCopyWithImpl(this._self, this._then);

  final _StockState _self;
  final $Res Function(_StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stocks = null,Object? filtered = null,Object? filterRole = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_StockState(
stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<StockModel>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<StockModel>,filterRole: freezed == filterRole ? _self.filterRole : filterRole // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
