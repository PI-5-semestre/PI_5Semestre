// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateUser {

 String get email; String get name; String get cpf; String get mobile; String? get password;// ignore: non_constant_identifier_names
 String? get account_type;// ignore: non_constant_identifier_names
 int get institution_id;
/// Create a copy of CreateUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateUserCopyWith<CreateUser> get copyWith => _$CreateUserCopyWithImpl<CreateUser>(this as CreateUser, _$identity);

  /// Serializes this CreateUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUser&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.password, password) || other.password == password)&&(identical(other.account_type, account_type) || other.account_type == account_type)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,name,cpf,mobile,password,account_type,institution_id);

@override
String toString() {
  return 'CreateUser(email: $email, name: $name, cpf: $cpf, mobile: $mobile, password: $password, account_type: $account_type, institution_id: $institution_id)';
}


}

/// @nodoc
abstract mixin class $CreateUserCopyWith<$Res>  {
  factory $CreateUserCopyWith(CreateUser value, $Res Function(CreateUser) _then) = _$CreateUserCopyWithImpl;
@useResult
$Res call({
 String email, String name, String cpf, String mobile, String? password, String? account_type, int institution_id
});




}
/// @nodoc
class _$CreateUserCopyWithImpl<$Res>
    implements $CreateUserCopyWith<$Res> {
  _$CreateUserCopyWithImpl(this._self, this._then);

  final CreateUser _self;
  final $Res Function(CreateUser) _then;

/// Create a copy of CreateUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? name = null,Object? cpf = null,Object? mobile = null,Object? password = freezed,Object? account_type = freezed,Object? institution_id = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,account_type: freezed == account_type ? _self.account_type : account_type // ignore: cast_nullable_to_non_nullable
as String?,institution_id: null == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateUser].
extension CreateUserPatterns on CreateUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateUser value)  $default,){
final _that = this;
switch (_that) {
case _CreateUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateUser value)?  $default,){
final _that = this;
switch (_that) {
case _CreateUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String name,  String cpf,  String mobile,  String? password,  String? account_type,  int institution_id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateUser() when $default != null:
return $default(_that.email,_that.name,_that.cpf,_that.mobile,_that.password,_that.account_type,_that.institution_id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String name,  String cpf,  String mobile,  String? password,  String? account_type,  int institution_id)  $default,) {final _that = this;
switch (_that) {
case _CreateUser():
return $default(_that.email,_that.name,_that.cpf,_that.mobile,_that.password,_that.account_type,_that.institution_id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String name,  String cpf,  String mobile,  String? password,  String? account_type,  int institution_id)?  $default,) {final _that = this;
switch (_that) {
case _CreateUser() when $default != null:
return $default(_that.email,_that.name,_that.cpf,_that.mobile,_that.password,_that.account_type,_that.institution_id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateUser implements CreateUser {
   _CreateUser({required this.email, required this.name, required this.cpf, required this.mobile, this.password, this.account_type, required this.institution_id});
  factory _CreateUser.fromJson(Map<String, dynamic> json) => _$CreateUserFromJson(json);

@override final  String email;
@override final  String name;
@override final  String cpf;
@override final  String mobile;
@override final  String? password;
// ignore: non_constant_identifier_names
@override final  String? account_type;
// ignore: non_constant_identifier_names
@override final  int institution_id;

/// Create a copy of CreateUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateUserCopyWith<_CreateUser> get copyWith => __$CreateUserCopyWithImpl<_CreateUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateUser&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.password, password) || other.password == password)&&(identical(other.account_type, account_type) || other.account_type == account_type)&&(identical(other.institution_id, institution_id) || other.institution_id == institution_id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,name,cpf,mobile,password,account_type,institution_id);

@override
String toString() {
  return 'CreateUser(email: $email, name: $name, cpf: $cpf, mobile: $mobile, password: $password, account_type: $account_type, institution_id: $institution_id)';
}


}

/// @nodoc
abstract mixin class _$CreateUserCopyWith<$Res> implements $CreateUserCopyWith<$Res> {
  factory _$CreateUserCopyWith(_CreateUser value, $Res Function(_CreateUser) _then) = __$CreateUserCopyWithImpl;
@override @useResult
$Res call({
 String email, String name, String cpf, String mobile, String? password, String? account_type, int institution_id
});




}
/// @nodoc
class __$CreateUserCopyWithImpl<$Res>
    implements _$CreateUserCopyWith<$Res> {
  __$CreateUserCopyWithImpl(this._self, this._then);

  final _CreateUser _self;
  final $Res Function(_CreateUser) _then;

/// Create a copy of CreateUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? name = null,Object? cpf = null,Object? mobile = null,Object? password = freezed,Object? account_type = freezed,Object? institution_id = null,}) {
  return _then(_CreateUser(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,account_type: freezed == account_type ? _self.account_type : account_type // ignore: cast_nullable_to_non_nullable
as String?,institution_id: null == institution_id ? _self.institution_id : institution_id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
