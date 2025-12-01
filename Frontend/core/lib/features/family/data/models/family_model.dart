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
    String? city,
    required String state,
    String? situation,
    String? income,
    String? description,
    required int institution_id,
    List<Member>? members,
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
}

@freezed
abstract class Member with _$Member {
  const Member._();

  const factory Member({
    int? id,
    DateTime? created,
    DateTime? modified,
    bool? active,
    required String name,
    required String cpf,
    required String kinship,
    int? family_id,
    bool? can_receive,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  String get roleKinship {
    switch (kinship) {
      case "SON":
        return "Filho(a)";
      case "SPOUSE":
        return "Cônjuge";
      case "FATHER":
        return "Pai";
      case "MOTHER":
        return "Mãe";
      case "OTHER":
        return "Outro";
      default:
        return "Desconhecido";
    }
  }
}
