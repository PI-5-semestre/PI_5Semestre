// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  account: Account.fromJson(json['account'] as Map<String, dynamic>),
  token: json['token'] as String,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'account': instance.account,
  'token': instance.token,
};

_Account _$AccountFromJson(Map<String, dynamic> json) => _Account(
  id: (json['id'] as num).toInt(),
  created: json['created'] as String,
  modified: json['modified'] as String,
  active: json['active'] as bool,
  email: json['email'] as String,
  account_type: json['account_type'] as String,
  institution_id: (json['institution_id'] as num).toInt(),
  profile: json['profile'] == null
      ? null
      : Profile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountToJson(_Account instance) => <String, dynamic>{
  'id': instance.id,
  'created': instance.created,
  'modified': instance.modified,
  'active': instance.active,
  'email': instance.email,
  'account_type': instance.account_type,
  'institution_id': instance.institution_id,
  'profile': instance.profile,
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  mobile: json['mobile'] as String,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'cpf': instance.cpf,
  'mobile': instance.mobile,
};
