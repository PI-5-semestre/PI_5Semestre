// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockModel _$StockModelFromJson(Map<String, dynamic> json) => _StockModel(
  id: (json['id'] as num?)?.toInt(),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  modified: json['modified'] == null
      ? null
      : DateTime.parse(json['modified'] as String),
  active: json['active'] as bool?,
  institution_id: (json['institution_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  sku: json['sku'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
);

Map<String, dynamic> _$StockModelToJson(_StockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'modified': instance.modified?.toIso8601String(),
      'active': instance.active,
      'institution_id': instance.institution_id,
      'name': instance.name,
      'sku': instance.sku,
      'quantity': instance.quantity,
    };
