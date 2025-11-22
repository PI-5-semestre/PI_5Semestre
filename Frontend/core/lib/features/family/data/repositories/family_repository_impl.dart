import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/interface/family_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_repository_impl.g.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final Dio dio;

  FamilyRepositoryImpl({required this.dio});

  @override
  Future<bool> create(FamilyModel family, String token) async {
    try {
      final response = await dio.post(
        '/institutions/1/families',
        data: family.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.statusCode == 201;

    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> delete(String cpf, String token) async {
    try {
      final response = await dio.delete(
        '/institutions/1/families/$cpf',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<List<FamilyModel>> findAll() async {
    try {
      final response = await dio.get('/institutions/1/families');
      return (response.data as List)
          .map((family) => FamilyModel.fromJson(family))
          .toList();
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> update(FamilyModel family, String token) async {
    try {
      final familyJson = family.toJson();

      if (family.persons != null && family.persons!.isNotEmpty) {
        familyJson['persons'] = family.persons!.map((p) => p.toJson()).toList();
      } else {
        familyJson.remove('persons');
      }

      final response = await dio.put(
        '/institutions/1/families/${family.cpf}',
        data: familyJson,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500 && family.persons != null && family.persons!.isNotEmpty) {
        throw Exception("Membro de família já cadastrado");
      }
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
FamilyRepository familyRepository(Ref ref) {
  return FamilyRepositoryImpl(dio: ref.watch(dioProvider));
}
