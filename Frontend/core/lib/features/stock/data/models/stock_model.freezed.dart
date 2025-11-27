// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockModel {

 int? get id; DateTime? get created; DateTime? get modified; bool? get active;// ignore: non_constant_identifier_names
 int? get institution_id; String? get name; String? get sku; int? get quantity;
/// Create a copy of StockModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockModelCopyWith<StockModel> get copyWith => _$StockModelCopyWithImpl<StockModel>(this as StockModel, _$identity);

  /// Serializes this StockModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockModel&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,institution_id,name,sku,quantity);

@override
String toString() {
  return 'StockModel(id: $id, created: $created, modified: $modified, active: $active, institution_id: $institution_id, name: $name, sku: $sku, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $StockModelCopyWith<$Res>  {
  factory $StockModelCopyWith(StockModel value, $Res Function(StockModel) _then) = _$StockModelCopyWithImpl;
@useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, int? institution_id, String? name, String? sku, int? quantity
});




}
/// @nodoc
class _$StockModelCopyWithImpl<$Res>
    implements $StockModelCopyWith<$Res> {
  _$StockModelCopyWithImpl(this._self, this._then);

  final StockModel _self;
  final $Res Function(StockModel) _then;

/// Create a copy of StockModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? institution_id = freezed,Object? name = freezed,Object? sku = freezed,Object? quantity = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockModel].
extension StockModelPatterns on StockModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockModel value)  $default,){
final _that = this;
switch (_that) {
case _StockModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  int? institution_id,  String? name,  String? sku,  int? quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockModel() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.institution_id,_that.name,_that.sku,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  int? institution_id,  String? name,  String? sku,  int? quantity)  $default,) {final _that = this;
switch (_that) {
case _StockModel():
return $default(_that.id,_that.created,_that.modified,_that.active,_that.institution_id,_that.name,_that.sku,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  int? institution_id,  String? name,  String? sku,  int? quantity)?  $default,) {final _that = this;
switch (_that) {
case _StockModel() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.institution_id,_that.name,_that.sku,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockModel implements StockModel {
  const _StockModel({this.id, this.created, this.modified, this.active, this.institution_id, this.name, this.sku, this.quantity});
  factory _StockModel.fromJson(Map<String, dynamic> json) => _$StockModelFromJson(json);

@override final  int? id;
@override final  DateTime? created;
@override final  DateTime? modified;
@override final  bool? active;
// ignore: non_constant_identifier_names
@override final  int? institution_id;
@override final  String? name;
@override final  String? sku;
@override final  int? quantity;

/// Create a copy of StockModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockModelCopyWith<_StockModel> get copyWith => __$StockModelCopyWithImpl<_StockModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockModel&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,institution_id,name,sku,quantity);

@override
String toString() {
  return 'StockModel(id: $id, created: $created, modified: $modified, active: $active, institution_id: $institution_id, name: $name, sku: $sku, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$StockModelCopyWith<$Res> implements $StockModelCopyWith<$Res> {
  factory _$StockModelCopyWith(_StockModel value, $Res Function(_StockModel) _then) = __$StockModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, int? institution_id, String? name, String? sku, int? quantity
});




}
/// @nodoc
class __$StockModelCopyWithImpl<$Res>
    implements _$StockModelCopyWith<$Res> {
  __$StockModelCopyWithImpl(this._self, this._then);

  final _StockModel _self;
  final $Res Function(_StockModel) _then;

/// Create a copy of StockModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? institution_id = freezed,Object? name = freezed,Object? sku = freezed,Object? quantity = freezed,}) {
  return _then(_StockModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
