// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateUser _$CreateUserFromJson(Map<String, dynamic> json) => _CreateUser(
  email: json['email'] as String,
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  mobile: json['mobile'] as String,
  password: json['password'] as String,
  account_type: json['account_type'] as String?,
  institution_id: (json['institution_id'] as num).toInt(),
);

Map<String, dynamic> _$CreateUserToJson(_CreateUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'cpf': instance.cpf,
      'mobile': instance.mobile,
      'password': instance.password,
      'account_type': instance.account_type,
      'institution_id': instance.institution_id,
    };
