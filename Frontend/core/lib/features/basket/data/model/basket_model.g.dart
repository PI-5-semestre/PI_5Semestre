// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BasketModel _$BasketModelFromJson(Map<String, dynamic> json) => _BasketModel(
  familyId: (json['family_id'] as num?)?.toInt(),
  type: json['type'] as String?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => BasketProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BasketModelToJson(_BasketModel instance) =>
    <String, dynamic>{
      'family_id': instance.familyId,
      'type': instance.type,
      'products': instance.products,
    };

_BasketProductModel _$BasketProductModelFromJson(Map<String, dynamic> json) =>
    _BasketProductModel(
      productSku: json['product_sku'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BasketProductModelToJson(_BasketProductModel instance) =>
    <String, dynamic>{
      'product_sku': instance.productSku,
      'quantity': instance.quantity,
    };
