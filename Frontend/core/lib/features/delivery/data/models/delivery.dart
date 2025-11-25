import 'package:core/features/family/data/models/family_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

@freezed
abstract class DeliveryModel with _$DeliveryModel {
  const DeliveryModel._();

  const factory DeliveryModel({
    int? id,
    bool? active,
    DateTime? created,
    int? institution_id,
    int? family_id,
    FamilyModel? family,
    DateTime? delivery_date,
    int? account_id,
    String? status,
    String? description,
  }) = _DeliveryModel;
  factory DeliveryModel.fromJson(Map<String, dynamic> json) => _$DeliveryModelFromJson(json);

  String get deliveryStatus {
    switch (status) {
      case "COMPLETED":
        return "Entregue";
      case "PENDING":
        return "Pendente";
      case "CANCELED":
        return "Não Entregue";
      default:
        return "Desconhecido";
    }
  }
}