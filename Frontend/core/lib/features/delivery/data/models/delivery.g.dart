// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeliveryModel _$DeliveryModelFromJson(Map<String, dynamic> json) =>
    _DeliveryModel(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      institution_id: (json['institution_id'] as num?)?.toInt(),
      family_id: (json['family_id'] as num?)?.toInt(),
      family: json['family'] == null
          ? null
          : FamilyModel.fromJson(json['family'] as Map<String, dynamic>),
      delivery_date: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
      account_id: (json['account_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      description: json['description'] as String?,
      attempts: (json['attempts'] as List<dynamic>?)
          ?.map((e) => Attempt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryModelToJson(_DeliveryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'created': instance.created?.toIso8601String(),
      'institution_id': instance.institution_id,
      'family_id': instance.family_id,
      'family': instance.family,
      'delivery_date': instance.delivery_date?.toIso8601String(),
      'account_id': instance.account_id,
      'status': instance.status,
      'description': instance.description,
      'attempts': instance.attempts,
    };

_Attempt _$AttemptFromJson(Map<String, dynamic> json) => _Attempt(
  id: (json['id'] as num?)?.toInt(),
  active: json['active'] as bool?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  family_delivery_id: (json['family_delivery_id'] as num?)?.toInt(),
  status: json['status'] as String?,
  attempt_date: json['attempt_date'] == null
      ? null
      : DateTime.parse(json['attempt_date'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$AttemptToJson(_Attempt instance) => <String, dynamic>{
  'id': instance.id,
  'active': instance.active,
  'created': instance.created?.toIso8601String(),
  'family_delivery_id': instance.family_delivery_id,
  'status': instance.status,
  'attempt_date': instance.attempt_date?.toIso8601String(),
  'description': instance.description,
};
