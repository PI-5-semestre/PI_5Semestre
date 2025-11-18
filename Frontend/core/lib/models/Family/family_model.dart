import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyModel with _$FamilyModel {
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
    required String state,
    required String situation,
    required String income,
    required String description,
    required int institution_id,
  }) = _FamilyModel;

  factory FamilyModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyModelFromJson(json);
}
