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
    required int institution_id,
    required int family_id,
    required FamilyModel family,
    required DateTime delivery_date,
    required int account_id,
    required String status,
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