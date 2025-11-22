import 'package:core/features/family/data/models/family_model.dart';

abstract interface class FamilyRepository {
  Future<List<FamilyModel>> findAll();
  Future<bool> update(FamilyModel family);
  Future<bool> create(FamilyModel family, String token);
  Future<bool> delete(String cpf, String token);
}
