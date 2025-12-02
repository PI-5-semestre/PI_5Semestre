import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_model.freezed.dart';
part 'basket_model.g.dart';

@freezed
abstract class BasketModel with _$BasketModel {
  const factory BasketModel({
    @JsonKey(name: 'family_id') int? familyId,
    String? type,
    List<BasketProductModel>? products,
  }) = _BasketModel;

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);
}

@freezed
abstract class BasketProductModel with _$BasketProductModel {
  const factory BasketProductModel({
    @JsonKey(name: 'product_sku') String? productSku,
    int? quantity,
  }) = _BasketProductModel;

  factory BasketProductModel.fromJson(Map<String, dynamic> json) =>
      _$BasketProductModelFromJson(json);
}
