import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyModel with _$FamilyModel {
  const FamilyModel._();

  const factory FamilyModel({
    int? id,
    DateTime? created,
    DateTime? modified,
    bool? active,
    required String name,
    required String cpf,
    required String mobile_phone,
    required String zip_code,
    required String street,
    required String number,
    required String neighborhood,
    required String? city,
    required String state,
    required String situation,
    required String income,
    required String description,
    required int institution_id,
    List<Person>? persons,
  }) = _FamilyModel;

  factory FamilyModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyModelFromJson(json);

  // Nome para exibição
  String get roleSituation {
    switch (situation) {
      case "ACTIVE":
        return "Ativa";
      case "PENDING":
        return "Pendente";
      case "INACTIVE":
        return "Inativa";
      case "SUSPENDED":
        return "Suspensa";
      default:
        return "Desconhecido";
    }
  }

  // Status de entrega
  String get deliveryStatus {
    switch (situation) {
      case "ACTIVE":
        return "Recebendo";
      case "PENDING":
        return "Aguardando";
      case "INACTIVE":
        return "Não Recebendo";
      case "SUSPENDED":
        return "Suspensa";
      default:
        return "Desconhecido";
    }
  }
}

@freezed
abstract class Person with _$Person {
  const factory Person({
    int? id,
    DateTime? created,
    DateTime? modified,
    bool? active,
    required String name,
    required String cpf,
    required String kinship,
    int? family_id,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
