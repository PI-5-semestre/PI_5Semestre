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
    List<Attempt>? attempts

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

@freezed
abstract class Attempt with _$Attempt {
  const factory Attempt ({
    int? id,
    bool? active,
    DateTime? created,
    int? family_delivery_id,
    String? status,
    DateTime? attempt_date,
    String? description
  }) = _Attempt;

  factory Attempt.fromJson(Map<String, dynamic> json) => _$AttemptFromJson(json);
}