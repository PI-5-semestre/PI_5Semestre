// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyModel {

 int? get id; DateTime? get created; DateTime? get modified; bool? get active; String get name; String get cpf; String get mobile_phone; String get zip_code; String get street; String get number; String get neighborhood; String? get city; String get state; String? get situation; String? get income; String? get description; int get institution_id; List<Person>? get persons;
/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<FamilyModel> get copyWith => _$FamilyModelCopyWithImpl<FamilyModel>(this as FamilyModel, _$identity);

  /// Serializes this FamilyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.mobile_phone, mobile_phone) || other.mobile_phone == mobile_phone)&&(identical(other.zip_code, zip_code) || other.zip_code == zip_code)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.situation, situation) || other.situation == situation)&&(identical(other.income, income) || other.income == income)&&(identical(other.description, description) || other.description == description)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&const DeepCollectionEquality().equals(other.persons, persons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,name,cpf,mobile_phone,zip_code,street,number,neighborhood,city,state,situation,income,description,institution_id,const DeepCollectionEquality().hash(persons));

@override
String toString() {
  return 'FamilyModel(id: $id, created: $created, modified: $modified, active: $active, name: $name, cpf: $cpf, mobile_phone: $mobile_phone, zip_code: $zip_code, street: $street, number: $number, neighborhood: $neighborhood, city: $city, state: $state, situation: $situation, income: $income, description: $description, institution_id: $institution_id, persons: $persons)';
}


}

/// @nodoc
abstract mixin class $FamilyModelCopyWith<$Res>  {
  factory $FamilyModelCopyWith(FamilyModel value, $Res Function(FamilyModel) _then) = _$FamilyModelCopyWithImpl;
@useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, String name, String cpf, String mobile_phone, String zip_code, String street, String number, String neighborhood, String? city, String state, String? situation, String? income, String? description, int institution_id, List<Person>? persons
});




}
/// @nodoc
class _$FamilyModelCopyWithImpl<$Res>
    implements $FamilyModelCopyWith<$Res> {
  _$FamilyModelCopyWithImpl(this._self, this._then);

  final FamilyModel _self;
  final $Res Function(FamilyModel) _then;

/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? name = null,Object? cpf = null,Object? mobile_phone = null,Object? zip_code = null,Object? street = null,Object? number = null,Object? neighborhood = null,Object? city = freezed,Object? state = null,Object? situation = freezed,Object? income = freezed,Object? description = freezed,Object? institution_id = null,Object? persons = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,mobile_phone: null == mobile_phone ? _self.mobile_phone : mobile_phone // ignore: cast_nullable_to_non_nullable
as String,zip_code: null == zip_code ? _self.zip_code : zip_code // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,situation: freezed == situation ? _self.situation : situation // ignore: cast_nullable_to_non_nullable
as String?,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,institution_id: null == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int,persons: freezed == persons ? _self.persons : persons // ignore: cast_nullable_to_non_nullable
as List<Person>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FamilyModel].
extension FamilyModelPatterns on FamilyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyModel value)  $default,){
final _that = this;
switch (_that) {
case _FamilyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyModel value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String mobile_phone,  String zip_code,  String street,  String number,  String neighborhood,  String? city,  String state,  String? situation,  String? income,  String? description,  int institution_id,  List<Person>? persons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyModel() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.mobile_phone,_that.zip_code,_that.street,_that.number,_that.neighborhood,_that.city,_that.state,_that.situation,_that.income,_that.description,_that.institution_id,_that.persons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String mobile_phone,  String zip_code,  String street,  String number,  String neighborhood,  String? city,  String state,  String? situation,  String? income,  String? description,  int institution_id,  List<Person>? persons)  $default,) {final _that = this;
switch (_that) {
case _FamilyModel():
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.mobile_phone,_that.zip_code,_that.street,_that.number,_that.neighborhood,_that.city,_that.state,_that.situation,_that.income,_that.description,_that.institution_id,_that.persons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String mobile_phone,  String zip_code,  String street,  String number,  String neighborhood,  String? city,  String state,  String? situation,  String? income,  String? description,  int institution_id,  List<Person>? persons)?  $default,) {final _that = this;
switch (_that) {
case _FamilyModel() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.mobile_phone,_that.zip_code,_that.street,_that.number,_that.neighborhood,_that.city,_that.state,_that.situation,_that.income,_that.description,_that.institution_id,_that.persons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyModel extends FamilyModel {
  const _FamilyModel({this.id, this.created, this.modified, this.active, required this.name, required this.cpf, required this.mobile_phone, required this.zip_code, required this.street, required this.number, required this.neighborhood, this.city, required this.state, this.situation, this.income, this.description, required this.institution_id, final  List<Person>? persons}): _persons = persons,super._();
  factory _FamilyModel.fromJson(Map<String, dynamic> json) => _$FamilyModelFromJson(json);

@override final  int? id;
@override final  DateTime? created;
@override final  DateTime? modified;
@override final  bool? active;
@override final  String name;
@override final  String cpf;
@override final  String mobile_phone;
@override final  String zip_code;
@override final  String street;
@override final  String number;
@override final  String neighborhood;
@override final  String? city;
@override final  String state;
@override final  String? situation;
@override final  String? income;
@override final  String? description;
@override final  int institution_id;
 final  List<Person>? _persons;
@override List<Person>? get persons {
  final value = _persons;
  if (value == null) return null;
  if (_persons is EqualUnmodifiableListView) return _persons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyModelCopyWith<_FamilyModel> get copyWith => __$FamilyModelCopyWithImpl<_FamilyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.mobile_phone, mobile_phone) || other.mobile_phone == mobile_phone)&&(identical(other.zip_code, zip_code) || other.zip_code == zip_code)&&(identical(other.street, street) || other.street == street)&&(identical(other.number, number) || other.number == number)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.situation, situation) || other.situation == situation)&&(identical(other.income, income) || other.income == income)&&(identical(other.description, description) || other.description == description)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id)&&const DeepCollectionEquality().equals(other._persons, _persons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,name,cpf,mobile_phone,zip_code,street,number,neighborhood,city,state,situation,income,description,institution_id,const DeepCollectionEquality().hash(_persons));

@override
String toString() {
  return 'FamilyModel(id: $id, created: $created, modified: $modified, active: $active, name: $name, cpf: $cpf, mobile_phone: $mobile_phone, zip_code: $zip_code, street: $street, number: $number, neighborhood: $neighborhood, city: $city, state: $state, situation: $situation, income: $income, description: $description, institution_id: $institution_id, persons: $persons)';
}


}

/// @nodoc
abstract mixin class _$FamilyModelCopyWith<$Res> implements $FamilyModelCopyWith<$Res> {
  factory _$FamilyModelCopyWith(_FamilyModel value, $Res Function(_FamilyModel) _then) = __$FamilyModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, String name, String cpf, String mobile_phone, String zip_code, String street, String number, String neighborhood, String? city, String state, String? situation, String? income, String? description, int institution_id, List<Person>? persons
});




}
/// @nodoc
class __$FamilyModelCopyWithImpl<$Res>
    implements _$FamilyModelCopyWith<$Res> {
  __$FamilyModelCopyWithImpl(this._self, this._then);

  final _FamilyModel _self;
  final $Res Function(_FamilyModel) _then;

/// Create a copy of FamilyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? name = null,Object? cpf = null,Object? mobile_phone = null,Object? zip_code = null,Object? street = null,Object? number = null,Object? neighborhood = null,Object? city = freezed,Object? state = null,Object? situation = freezed,Object? income = freezed,Object? description = freezed,Object? institution_id = null,Object? persons = freezed,}) {
  return _then(_FamilyModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,mobile_phone: null == mobile_phone ? _self.mobile_phone : mobile_phone // ignore: cast_nullable_to_non_nullable
as String,zip_code: null == zip_code ? _self.zip_code : zip_code // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,situation: freezed == situation ? _self.situation : situation // ignore: cast_nullable_to_non_nullable
as String?,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,institution_id: null == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int,persons: freezed == persons ? _self._persons : persons // ignore: cast_nullable_to_non_nullable
as List<Person>?,
  ));
}


}


/// @nodoc
mixin _$Person {

 int? get id; DateTime? get created; DateTime? get modified; bool? get active; String get name; String get cpf; String get kinship; int? get family_id;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);

  /// Serializes this Person to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.kinship, kinship) || other.kinship == kinship)&&(identical(other.family_id, family_id) || other.family_id == family_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,name,cpf,kinship,family_id);

@override
String toString() {
  return 'Person(id: $id, created: $created, modified: $modified, active: $active, name: $name, cpf: $cpf, kinship: $kinship, family_id: $family_id)';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, String name, String cpf, String kinship, int? family_id
});




}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? name = null,Object? cpf = null,Object? kinship = null,Object? family_id = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,kinship: null == kinship ? _self.kinship : kinship // ignore: cast_nullable_to_non_nullable
as String,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String kinship,  int? family_id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.kinship,_that.family_id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String kinship,  int? family_id)  $default,) {final _that = this;
switch (_that) {
case _Person():
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.kinship,_that.family_id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  DateTime? created,  DateTime? modified,  bool? active,  String name,  String cpf,  String kinship,  int? family_id)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.id,_that.created,_that.modified,_that.active,_that.name,_that.cpf,_that.kinship,_that.family_id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Person implements Person {
  const _Person({this.id, this.created, this.modified, this.active, required this.name, required this.cpf, required this.kinship, this.family_id});
  factory _Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

@override final  int? id;
@override final  DateTime? created;
@override final  DateTime? modified;
@override final  bool? active;
@override final  String name;
@override final  String cpf;
@override final  String kinship;
@override final  int? family_id;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.modified, modified) || other.modified == modified)&&(identical(other.active, active) || other.active == active)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.kinship, kinship) || other.kinship == kinship)&&(identical(other.family_id, family_id) || other.family_id == family_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,modified,active,name,cpf,kinship,family_id);

@override
String toString() {
  return 'Person(id: $id, created: $created, modified: $modified, active: $active, name: $name, cpf: $cpf, kinship: $kinship, family_id: $family_id)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 int? id, DateTime? created, DateTime? modified, bool? active, String name, String cpf, String kinship, int? family_id
});




}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? created = freezed,Object? modified = freezed,Object? active = freezed,Object? name = null,Object? cpf = null,Object? kinship = null,Object? family_id = freezed,}) {
  return _then(_Person(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,modified: freezed == modified ? _self.modified : modified // ignore: cast_nullable_to_non_nullable
as DateTime?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,kinship: null == kinship ? _self.kinship : kinship // ignore: cast_nullable_to_non_nullable
as String,family_id: freezed == family_id ? _self.family_id : family_id // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
