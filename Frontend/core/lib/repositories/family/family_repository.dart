import 'package:core/models/Family/family_model.dart';

abstract interface class FamilyRepository {
  Future<List<FamilyModel>> findAll();
  Future<bool> update(FamilyModel family);
  Future<bool> create(FamilyModel fanily);
  Future<bool> delete(FamilyModel family);
}
