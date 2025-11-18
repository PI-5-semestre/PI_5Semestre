import 'dart:convert';

import 'package:core/models/Family/family_model.dart';
import 'package:core/features/family/data/family_repository.dart';
import 'package:core/features/auth/presentation/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_repository_impl.g.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final Dio dio;

  FamilyRepositoryImpl({required this.dio});

  @override
  Future<bool> create(FamilyModel family) async {
    try {
      final response = await dio.post(
        '/institutions/1/families',
        data: family.toJson(),
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          'Erro ao criar a família';

      throw Exception(message);
    }
  }

  @override
  Future<bool> delete(FamilyModel family) async {
    try {
      final response = await dio.delete(
        '/institutions/1/families/${family.cpf}',
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          'Falha ao deletar família';
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
      final message =
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          'Falha ao recuperar dados';
      throw Exception(message);
    }
  }

  @override
  Future<bool> update(FamilyModel family) async {
    try {
      final response = await dio.put(
        '/institutions/1/families/${family.cpf}',
        data: family,
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail'] ??
          e.response?.data['message'] ??
          'Falha ao atualizar família';
      throw Exception(message);
    }
  }
}

@riverpod
FamilyRepository familyRepository(Ref ref) {
  return FamilyRepositoryImpl(dio: ref.watch(dioProvider));
}
