import 'package:core/features/family/data/models/family_model.dart';

abstract interface class FamilyRepository {
  Future<List<FamilyModel>> findAll();
  Future<bool> create(FamilyModel family, String token);
  Future<bool> update(FamilyModel family, String token);
  Future<bool> delete(String cpf, String token);
  Future<bool> uploadDocument({
    required String cpf,
    required String docType,
    required String filePath,
  });
  Future<List<dynamic>> getDocuments(String cpf);
  Future<void> downloadDocument(String cpf, int id);
}
