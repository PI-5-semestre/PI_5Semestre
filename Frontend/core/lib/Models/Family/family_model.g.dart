// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyModel _$FamilyModelFromJson(Map<String, dynamic> json) => _FamilyModel(
  id: (json['id'] as num?)?.toInt(),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  modified: json['modified'] == null
      ? null
      : DateTime.parse(json['modified'] as String),
  active: json['active'] as bool?,
  name: json['name'] as String,
  cpf: json['cpf'] as String,
  mobile_phone: json['mobile_phone'] as String,
  zip_code: json['zip_code'] as String,
  street: json['street'] as String,
  number: json['number'] as String,
  neighborhood: json['neighborhood'] as String,
  state: json['state'] as String,
  situation: json['situation'] as String,
  income: json['income'] as String,
  description: json['description'] as String,
  institution_id: (json['institution_id'] as num).toInt(),
);

Map<String, dynamic> _$FamilyModelToJson(_FamilyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'modified': instance.modified?.toIso8601String(),
      'active': instance.active,
      'name': instance.name,
      'cpf': instance.cpf,
      'mobile_phone': instance.mobile_phone,
      'zip_code': instance.zip_code,
      'street': instance.street,
      'number': instance.number,
      'neighborhood': instance.neighborhood,
      'state': instance.state,
      'situation': instance.situation,
      'income': instance.income,
      'description': instance.description,
      'institution_id': instance.institution_id,
    };
