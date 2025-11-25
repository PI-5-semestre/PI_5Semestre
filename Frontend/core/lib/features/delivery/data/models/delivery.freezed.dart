// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeliveryModel {

 int? get id; bool? get active; DateTime? get created; int? get institution_id; int? get family_id; FamilyModel? get family; DateTime? get delivery_date; int? get account_id; String? get status; String? get description; List<Attempt>? get attempts;
/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryModelCopyWith<DeliveryModel> get copyWith => _$DeliveryModelCopyWithImpl<DeliveryModel>(this as DeliveryModel, _$identity);

  /// Serializes this DeliveryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.family_id, family_id) || other.family_id == family_id)&&(identical(other.family, family) || other.family == family)&&(identical(other.delivery_date, delivery_date) || other.delivery_date == delivery_date)&&(identical(other.account_id, account_id) || other.account_id == account_id)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.attempts, attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,institution_id,family_id,family,delivery_date,account_id,status,description,const DeepCollectionEquality().hash(attempts));

@override
String toString() {
  return 'DeliveryModel(id: $id, active: $active, created: $created, institution_id: $institution_id, family_id: $family_id, family: $family, delivery_date: $delivery_date, account_id: $account_id, status: $status, description: $description, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class $DeliveryModelCopyWith<$Res>  {
  factory $DeliveryModelCopyWith(DeliveryModel value, $Res Function(DeliveryModel) _then) = _$DeliveryModelCopyWithImpl;
@useResult
$Res call({
 int? id, bool? active, DateTime? created, int? institution_id, int? family_id, FamilyModel? family, DateTime? delivery_date, int? account_id, String? status, String? description, List<Attempt>? attempts
});


$FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class _$DeliveryModelCopyWithImpl<$Res>
    implements $DeliveryModelCopyWith<$Res> {
  _$DeliveryModelCopyWithImpl(this._self, this._then);

  final DeliveryModel _self;
  final $Res Function(DeliveryModel) _then;

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? institution_id = freezed,Object? family_id = freezed,Object? family = freezed,Object? delivery_date = freezed,Object? account_id = freezed,Object? status = freezed,Object? description = freezed,Object? attempts = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,delivery_date: freezed == delivery_date ? _self.delivery_date : delivery_date // ignore: cast_nullable_to_non_nullable
as DateTime?,account_id: freezed == account_id ? _self.account_id : account_id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,attempts: freezed == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as List<Attempt>?,
  ));
}
/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeliveryModel].
extension DeliveryModelPatterns on DeliveryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryModel value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryModel value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int? family_id,  FamilyModel? family,  DateTime? delivery_date,  int? account_id,  String? status,  String? description,  List<Attempt>? attempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.family_id,_that.family,_that.delivery_date,_that.account_id,_that.status,_that.description,_that.attempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int? family_id,  FamilyModel? family,  DateTime? delivery_date,  int? account_id,  String? status,  String? description,  List<Attempt>? attempts)  $default,) {final _that = this;
switch (_that) {
case _DeliveryModel():
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.family_id,_that.family,_that.delivery_date,_that.account_id,_that.status,_that.description,_that.attempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  bool? active,  DateTime? created,  int? institution_id,  int? family_id,  FamilyModel? family,  DateTime? delivery_date,  int? account_id,  String? status,  String? description,  List<Attempt>? attempts)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryModel() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.institution_id,_that.family_id,_that.family,_that.delivery_date,_that.account_id,_that.status,_that.description,_that.attempts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryModel extends DeliveryModel {
  const _DeliveryModel({this.id, this.active, this.created, this.institution_id, this.family_id, this.family, this.delivery_date, this.account_id, this.status, this.description, final  List<Attempt>? attempts}): _attempts = attempts,super._();
  factory _DeliveryModel.fromJson(Map<String, dynamic> json) => _$DeliveryModelFromJson(json);

@override final  int? id;
@override final  bool? active;
@override final  DateTime? created;
@override final  int? institution_id;
@override final  int? family_id;
@override final  FamilyModel? family;
@override final  DateTime? delivery_date;
@override final  int? account_id;
@override final  String? status;
@override final  String? description;
 final  List<Attempt>? _attempts;
@override List<Attempt>? get attempts {
  final value = _attempts;
  if (value == null) return null;
  if (_attempts is EqualUnmodifiableListView) return _attempts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryModelCopyWith<_DeliveryModel> get copyWith => __$DeliveryModelCopyWithImpl<_DeliveryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&(identical(other.family_id, family_id) || other.family_id == family_id)&&(identical(other.family, family) || other.family == family)&&(identical(other.delivery_date, delivery_date) || other.delivery_date == delivery_date)&&(identical(other.account_id, account_id) || other.account_id == account_id)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._attempts, _attempts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,institution_id,family_id,family,delivery_date,account_id,status,description,const DeepCollectionEquality().hash(_attempts));

@override
String toString() {
  return 'DeliveryModel(id: $id, active: $active, created: $created, institution_id: $institution_id, family_id: $family_id, family: $family, delivery_date: $delivery_date, account_id: $account_id, status: $status, description: $description, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class _$DeliveryModelCopyWith<$Res> implements $DeliveryModelCopyWith<$Res> {
  factory _$DeliveryModelCopyWith(_DeliveryModel value, $Res Function(_DeliveryModel) _then) = __$DeliveryModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, bool? active, DateTime? created, int? institution_id, int? family_id, FamilyModel? family, DateTime? delivery_date, int? account_id, String? status, String? description, List<Attempt>? attempts
});


@override $FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class __$DeliveryModelCopyWithImpl<$Res>
    implements _$DeliveryModelCopyWith<$Res> {
  __$DeliveryModelCopyWithImpl(this._self, this._then);

  final _DeliveryModel _self;
  final $Res Function(_DeliveryModel) _then;

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? institution_id = freezed,Object? family_id = freezed,Object? family = freezed,Object? delivery_date = freezed,Object? account_id = freezed,Object? status = freezed,Object? description = freezed,Object? attempts = freezed,}) {
  return _then(_DeliveryModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,institution_id: freezed == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int?,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,delivery_date: freezed == delivery_date ? _self.delivery_date : delivery_date // ignore: cast_nullable_to_non_nullable
as DateTime?,account_id: freezed == account_id ? _self.account_id : account_id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,attempts: freezed == attempts ? _self._attempts : attempts // ignore: cast_nullable_to_non_nullable
as List<Attempt>?,
  ));
}

/// Create a copy of DeliveryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}


/// @nodoc
mixin _$Attempt {

 int? get id; bool? get active; DateTime? get created; int? get family_delivery_id; String? get status; DateTime? get attempt_date; String? get description;
/// Create a copy of Attempt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttemptCopyWith<Attempt> get copyWith => _$AttemptCopyWithImpl<Attempt>(this as Attempt, _$identity);

  /// Serializes this Attempt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attempt&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.family_delivery_id, family_delivery_id) || other.family_delivery_id == family_delivery_id)&&(identical(other.status, status) || other.status == status)&&(identical(other.attempt_date, attempt_date) || other.attempt_date == attempt_date)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,family_delivery_id,status,attempt_date,description);

@override
String toString() {
  return 'Attempt(id: $id, active: $active, created: $created, family_delivery_id: $family_delivery_id, status: $status, attempt_date: $attempt_date, description: $description)';
}


}

/// @nodoc
abstract mixin class $AttemptCopyWith<$Res>  {
  factory $AttemptCopyWith(Attempt value, $Res Function(Attempt) _then) = _$AttemptCopyWithImpl;
@useResult
$Res call({
 int? id, bool? active, DateTime? created, int? family_delivery_id, String? status, DateTime? attempt_date, String? description
});




}
/// @nodoc
class _$AttemptCopyWithImpl<$Res>
    implements $AttemptCopyWith<$Res> {
  _$AttemptCopyWithImpl(this._self, this._then);

  final Attempt _self;
  final $Res Function(Attempt) _then;

/// Create a copy of Attempt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? family_delivery_id = freezed,Object? status = freezed,Object? attempt_date = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,family_delivery_id: freezed == family_delivery_id ? _self.family_delivery_id : family_delivery_id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,attempt_date: freezed == attempt_date ? _self.attempt_date : attempt_date // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Attempt].
extension AttemptPatterns on Attempt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attempt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attempt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attempt value)  $default,){
final _that = this;
switch (_that) {
case _Attempt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attempt value)?  $default,){
final _that = this;
switch (_that) {
case _Attempt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? family_delivery_id,  String? status,  DateTime? attempt_date,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attempt() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.family_delivery_id,_that.status,_that.attempt_date,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  bool? active,  DateTime? created,  int? family_delivery_id,  String? status,  DateTime? attempt_date,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Attempt():
return $default(_that.id,_that.active,_that.created,_that.family_delivery_id,_that.status,_that.attempt_date,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  bool? active,  DateTime? created,  int? family_delivery_id,  String? status,  DateTime? attempt_date,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Attempt() when $default != null:
return $default(_that.id,_that.active,_that.created,_that.family_delivery_id,_that.status,_that.attempt_date,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attempt implements Attempt {
  const _Attempt({this.id, this.active, this.created, this.family_delivery_id, this.status, this.attempt_date, this.description});
  factory _Attempt.fromJson(Map<String, dynamic> json) => _$AttemptFromJson(json);

@override final  int? id;
@override final  bool? active;
@override final  DateTime? created;
@override final  int? family_delivery_id;
@override final  String? status;
@override final  DateTime? attempt_date;
@override final  String? description;

/// Create a copy of Attempt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttemptCopyWith<_Attempt> get copyWith => __$AttemptCopyWithImpl<_Attempt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttemptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attempt&&(identical(other.id, id) || other.id == id)&&(identical(other.active, active) || other.active == active)&&(identical(other.created, created) || other.created == created)&&(identical(other.family_delivery_id, family_delivery_id) || other.family_delivery_id == family_delivery_id)&&(identical(other.status, status) || other.status == status)&&(identical(other.attempt_date, attempt_date) || other.attempt_date == attempt_date)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,active,created,family_delivery_id,status,attempt_date,description);

@override
String toString() {
  return 'Attempt(id: $id, active: $active, created: $created, family_delivery_id: $family_delivery_id, status: $status, attempt_date: $attempt_date, description: $description)';
}


}

/// @nodoc
abstract mixin class _$AttemptCopyWith<$Res> implements $AttemptCopyWith<$Res> {
  factory _$AttemptCopyWith(_Attempt value, $Res Function(_Attempt) _then) = __$AttemptCopyWithImpl;
@override @useResult
$Res call({
 int? id, bool? active, DateTime? created, int? family_delivery_id, String? status, DateTime? attempt_date, String? description
});




}
/// @nodoc
class __$AttemptCopyWithImpl<$Res>
    implements _$AttemptCopyWith<$Res> {
  __$AttemptCopyWithImpl(this._self, this._then);

  final _Attempt _self;
  final $Res Function(_Attempt) _then;

/// Create a copy of Attempt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? active = freezed,Object? created = freezed,Object? family_delivery_id = freezed,Object? status = freezed,Object? attempt_date = freezed,Object? description = freezed,}) {
  return _then(_Attempt(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,family_delivery_id: freezed == family_delivery_id ? _self.family_delivery_id : family_delivery_id // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,attempt_date: freezed == attempt_date ? _self.attempt_date : attempt_date // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
