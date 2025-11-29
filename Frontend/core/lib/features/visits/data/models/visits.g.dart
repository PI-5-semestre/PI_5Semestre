// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Visits _$VisitsFromJson(Map<String, dynamic> json) => _Visits(
  id: (json['id'] as num?)?.toInt(),
  active: json['active'] as bool?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  institution_id: (json['institution_id'] as num?)?.toInt(),
  account_id: (json['account_id'] as num).toInt(),
  family_id: (json['family_id'] as num?)?.toInt(),
  visit_at: json['visit_at'] as String,
  description: json['description'] as String?,
  type_of_visit: json['type_of_visit'] as String,
  response: json['response'] == null
      ? null
      : Response.fromJson(json['response'] as Map<String, dynamic>),
  family: json['family'] == null
      ? null
      : FamilyModel.fromJson(json['family'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VisitsToJson(_Visits instance) => <String, dynamic>{
  'id': instance.id,
  'active': instance.active,
  'created': instance.created?.toIso8601String(),
  'institution_id': instance.institution_id,
  'account_id': instance.account_id,
  'family_id': instance.family_id,
  'visit_at': instance.visit_at,
  'description': instance.description,
  'type_of_visit': instance.type_of_visit,
  'response': instance.response,
  'family': instance.family,
};

_Response _$ResponseFromJson(Map<String, dynamic> json) => _Response(
  visitation_id: (json['visitation_id'] as num?)?.toInt(),
  description: json['description'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ResponseToJson(_Response instance) => <String, dynamic>{
  'visitation_id': instance.visitation_id,
  'description': instance.description,
  'status': instance.status,
};
