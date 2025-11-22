// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cep.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cep {

 String get cep; String get logradouro; String get complemento; String get bairro; String get localidade; String get uf;
/// Create a copy of Cep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CepCopyWith<Cep> get copyWith => _$CepCopyWithImpl<Cep>(this as Cep, _$identity);

  /// Serializes this Cep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cep&&(identical(other.cep, cep) || other.cep == cep)&&(identical(other.logradouro, logradouro) || other.logradouro == logradouro)&&(identical(other.complemento, complemento) || other.complemento == complemento)&&(identical(other.bairro, bairro) || other.bairro == bairro)&&(identical(other.localidade, localidade) || other.localidade == localidade)&&(identical(other.uf, uf) || other.uf == uf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cep,logradouro,complemento,bairro,localidade,uf);

@override
String toString() {
  return 'Cep(cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uf: $uf)';
}


}

/// @nodoc
abstract mixin class $CepCopyWith<$Res>  {
  factory $CepCopyWith(Cep value, $Res Function(Cep) _then) = _$CepCopyWithImpl;
@useResult
$Res call({
 String cep, String logradouro, String complemento, String bairro, String localidade, String uf
});




}
/// @nodoc
class _$CepCopyWithImpl<$Res>
    implements $CepCopyWith<$Res> {
  _$CepCopyWithImpl(this._self, this._then);

  final Cep _self;
  final $Res Function(Cep) _then;

/// Create a copy of Cep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cep = null,Object? logradouro = null,Object? complemento = null,Object? bairro = null,Object? localidade = null,Object? uf = null,}) {
  return _then(_self.copyWith(
cep: null == cep ? _self.cep : cep // ignore: cast_nullable_to_non_nullable
as String,logradouro: null == logradouro ? _self.logradouro : logradouro // ignore: cast_nullable_to_non_nullable
as String,complemento: null == complemento ? _self.complemento : complemento // ignore: cast_nullable_to_non_nullable
as String,bairro: null == bairro ? _self.bairro : bairro // ignore: cast_nullable_to_non_nullable
as String,localidade: null == localidade ? _self.localidade : localidade // ignore: cast_nullable_to_non_nullable
as String,uf: null == uf ? _self.uf : uf // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Cep].
extension CepPatterns on Cep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cep value)  $default,){
final _that = this;
switch (_that) {
case _Cep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cep value)?  $default,){
final _that = this;
switch (_that) {
case _Cep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cep,  String logradouro,  String complemento,  String bairro,  String localidade,  String uf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cep() when $default != null:
return $default(_that.cep,_that.logradouro,_that.complemento,_that.bairro,_that.localidade,_that.uf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cep,  String logradouro,  String complemento,  String bairro,  String localidade,  String uf)  $default,) {final _that = this;
switch (_that) {
case _Cep():
return $default(_that.cep,_that.logradouro,_that.complemento,_that.bairro,_that.localidade,_that.uf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cep,  String logradouro,  String complemento,  String bairro,  String localidade,  String uf)?  $default,) {final _that = this;
switch (_that) {
case _Cep() when $default != null:
return $default(_that.cep,_that.logradouro,_that.complemento,_that.bairro,_that.localidade,_that.uf);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cep implements Cep {
   _Cep({required this.cep, required this.logradouro, required this.complemento, required this.bairro, required this.localidade, required this.uf});
  factory _Cep.fromJson(Map<String, dynamic> json) => _$CepFromJson(json);

@override final  String cep;
@override final  String logradouro;
@override final  String complemento;
@override final  String bairro;
@override final  String localidade;
@override final  String uf;

/// Create a copy of Cep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CepCopyWith<_Cep> get copyWith => __$CepCopyWithImpl<_Cep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cep&&(identical(other.cep, cep) || other.cep == cep)&&(identical(other.logradouro, logradouro) || other.logradouro == logradouro)&&(identical(other.complemento, complemento) || other.complemento == complemento)&&(identical(other.bairro, bairro) || other.bairro == bairro)&&(identical(other.localidade, localidade) || other.localidade == localidade)&&(identical(other.uf, uf) || other.uf == uf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cep,logradouro,complemento,bairro,localidade,uf);

@override
String toString() {
  return 'Cep(cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uf: $uf)';
}


}

/// @nodoc
abstract mixin class _$CepCopyWith<$Res> implements $CepCopyWith<$Res> {
  factory _$CepCopyWith(_Cep value, $Res Function(_Cep) _then) = __$CepCopyWithImpl;
@override @useResult
$Res call({
 String cep, String logradouro, String complemento, String bairro, String localidade, String uf
});




}
/// @nodoc
class __$CepCopyWithImpl<$Res>
    implements _$CepCopyWith<$Res> {
  __$CepCopyWithImpl(this._self, this._then);

  final _Cep _self;
  final $Res Function(_Cep) _then;

/// Create a copy of Cep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cep = null,Object? logradouro = null,Object? complemento = null,Object? bairro = null,Object? localidade = null,Object? uf = null,}) {
  return _then(_Cep(
cep: null == cep ? _self.cep : cep // ignore: cast_nullable_to_non_nullable
as String,logradouro: null == logradouro ? _self.logradouro : logradouro // ignore: cast_nullable_to_non_nullable
as String,complemento: null == complemento ? _self.complemento : complemento // ignore: cast_nullable_to_non_nullable
as String,bairro: null == bairro ? _self.bairro : bairro // ignore: cast_nullable_to_non_nullable
as String,localidade: null == localidade ? _self.localidade : localidade // ignore: cast_nullable_to_non_nullable
as String,uf: null == uf ? _self.uf : uf // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
