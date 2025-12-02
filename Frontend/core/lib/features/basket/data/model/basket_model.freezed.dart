// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BasketModel {

@JsonKey(name: 'family_id') int? get familyId; String? get type; List<BasketProductModel>? get products;
/// Create a copy of BasketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BasketModelCopyWith<BasketModel> get copyWith => _$BasketModelCopyWithImpl<BasketModel>(this as BasketModel, _$identity);

  /// Serializes this BasketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasketModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.products, products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,type,const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'BasketModel(familyId: $familyId, type: $type, products: $products)';
}


}

/// @nodoc
abstract mixin class $BasketModelCopyWith<$Res>  {
  factory $BasketModelCopyWith(BasketModel value, $Res Function(BasketModel) _then) = _$BasketModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'family_id') int? familyId, String? type, List<BasketProductModel>? products
});




}
/// @nodoc
class _$BasketModelCopyWithImpl<$Res>
    implements $BasketModelCopyWith<$Res> {
  _$BasketModelCopyWithImpl(this._self, this._then);

  final BasketModel _self;
  final $Res Function(BasketModel) _then;

/// Create a copy of BasketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? familyId = freezed,Object? type = freezed,Object? products = freezed,}) {
  return _then(_self.copyWith(
familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<BasketProductModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BasketModel].
extension BasketModelPatterns on BasketModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BasketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BasketModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BasketModel value)  $default,){
final _that = this;
switch (_that) {
case _BasketModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BasketModel value)?  $default,){
final _that = this;
switch (_that) {
case _BasketModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'family_id')  int? familyId,  String? type,  List<BasketProductModel>? products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BasketModel() when $default != null:
return $default(_that.familyId,_that.type,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'family_id')  int? familyId,  String? type,  List<BasketProductModel>? products)  $default,) {final _that = this;
switch (_that) {
case _BasketModel():
return $default(_that.familyId,_that.type,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'family_id')  int? familyId,  String? type,  List<BasketProductModel>? products)?  $default,) {final _that = this;
switch (_that) {
case _BasketModel() when $default != null:
return $default(_that.familyId,_that.type,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BasketModel implements BasketModel {
  const _BasketModel({@JsonKey(name: 'family_id') this.familyId, this.type, final  List<BasketProductModel>? products}): _products = products;
  factory _BasketModel.fromJson(Map<String, dynamic> json) => _$BasketModelFromJson(json);

@override@JsonKey(name: 'family_id') final  int? familyId;
@override final  String? type;
 final  List<BasketProductModel>? _products;
@override List<BasketProductModel>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BasketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BasketModelCopyWith<_BasketModel> get copyWith => __$BasketModelCopyWithImpl<_BasketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BasketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BasketModel&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,familyId,type,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'BasketModel(familyId: $familyId, type: $type, products: $products)';
}


}

/// @nodoc
abstract mixin class _$BasketModelCopyWith<$Res> implements $BasketModelCopyWith<$Res> {
  factory _$BasketModelCopyWith(_BasketModel value, $Res Function(_BasketModel) _then) = __$BasketModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'family_id') int? familyId, String? type, List<BasketProductModel>? products
});




}
/// @nodoc
class __$BasketModelCopyWithImpl<$Res>
    implements _$BasketModelCopyWith<$Res> {
  __$BasketModelCopyWithImpl(this._self, this._then);

  final _BasketModel _self;
  final $Res Function(_BasketModel) _then;

/// Create a copy of BasketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? familyId = freezed,Object? type = freezed,Object? products = freezed,}) {
  return _then(_BasketModel(
familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<BasketProductModel>?,
  ));
}


}


/// @nodoc
mixin _$BasketProductModel {

@JsonKey(name: 'product_sku') String? get productSku; int? get quantity;
/// Create a copy of BasketProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BasketProductModelCopyWith<BasketProductModel> get copyWith => _$BasketProductModelCopyWithImpl<BasketProductModel>(this as BasketProductModel, _$identity);

  /// Serializes this BasketProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasketProductModel&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productSku,quantity);

@override
String toString() {
  return 'BasketProductModel(productSku: $productSku, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $BasketProductModelCopyWith<$Res>  {
  factory $BasketProductModelCopyWith(BasketProductModel value, $Res Function(BasketProductModel) _then) = _$BasketProductModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_sku') String? productSku, int? quantity
});




}
/// @nodoc
class _$BasketProductModelCopyWithImpl<$Res>
    implements $BasketProductModelCopyWith<$Res> {
  _$BasketProductModelCopyWithImpl(this._self, this._then);

  final BasketProductModel _self;
  final $Res Function(BasketProductModel) _then;

/// Create a copy of BasketProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productSku = freezed,Object? quantity = freezed,}) {
  return _then(_self.copyWith(
productSku: freezed == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BasketProductModel].
extension BasketProductModelPatterns on BasketProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BasketProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BasketProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BasketProductModel value)  $default,){
final _that = this;
switch (_that) {
case _BasketProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BasketProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _BasketProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_sku')  String? productSku,  int? quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BasketProductModel() when $default != null:
return $default(_that.productSku,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_sku')  String? productSku,  int? quantity)  $default,) {final _that = this;
switch (_that) {
case _BasketProductModel():
return $default(_that.productSku,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_sku')  String? productSku,  int? quantity)?  $default,) {final _that = this;
switch (_that) {
case _BasketProductModel() when $default != null:
return $default(_that.productSku,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BasketProductModel implements BasketProductModel {
  const _BasketProductModel({@JsonKey(name: 'product_sku') this.productSku, this.quantity});
  factory _BasketProductModel.fromJson(Map<String, dynamic> json) => _$BasketProductModelFromJson(json);

@override@JsonKey(name: 'product_sku') final  String? productSku;
@override final  int? quantity;

/// Create a copy of BasketProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BasketProductModelCopyWith<_BasketProductModel> get copyWith => __$BasketProductModelCopyWithImpl<_BasketProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BasketProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BasketProductModel&&(identical(other.productSku, productSku) || other.productSku == productSku)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productSku,quantity);

@override
String toString() {
  return 'BasketProductModel(productSku: $productSku, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$BasketProductModelCopyWith<$Res> implements $BasketProductModelCopyWith<$Res> {
  factory _$BasketProductModelCopyWith(_BasketProductModel value, $Res Function(_BasketProductModel) _then) = __$BasketProductModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_sku') String? productSku, int? quantity
});




}
/// @nodoc
class __$BasketProductModelCopyWithImpl<$Res>
    implements _$BasketProductModelCopyWith<$Res> {
  __$BasketProductModelCopyWithImpl(this._self, this._then);

  final _BasketProductModel _self;
  final $Res Function(_BasketProductModel) _then;

/// Create a copy of BasketProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productSku = freezed,Object? quantity = freezed,}) {
  return _then(_BasketProductModel(
productSku: freezed == productSku ? _self.productSku : productSku // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
