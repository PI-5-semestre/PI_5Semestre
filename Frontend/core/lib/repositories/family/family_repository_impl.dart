import 'package:core/models/Family/family_model.dart';
import 'package:core/repositories/family/family_repository.dart';
import 'package:core/features/auth/presentation/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_repository_impl.g.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final Dio dio;

  FamilyRepositoryImpl({required this.dio});

  @override
  Future<bool> create(FamilyModel family) async {
    bool value = false;

    try {
      final response = await dio.post(
        '/institutions/1/families',
        data: family.toJson(),
      );

      value = response.statusCode == 200;
      print(response.data);
    } catch (e) {
      print(e);
    }

    return value;
  }

  @override
  Future<bool> delete(FamilyModel family) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<FamilyModel>> findAll() async {
    try {
      final response = await dio.get('families');
      throw UnimplementedError();
    } on DioException catch (e) {
      final message =
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          'Falha ao recuperar dados';
      throw Exception(message);
    }
  }

  @override
  Future<bool> update(FamilyModel family) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

@riverpod
FamilyRepository familyRepository(Ref ref) {
  return FamilyRepositoryImpl(dio: ref.watch(dioProvider));
}
