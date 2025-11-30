import 'dart:convert';

import 'package:core/features/visits/data/models/visits.dart';
import 'package:core/features/visits/interface/visit_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visit_repository_impl.g.dart';

class VisitRepositoryImpl implements VisitRepository {
  final Dio dio;

  VisitRepositoryImpl({ required this.dio });

  @override
  Future<List<Visit>> fetchVisits(String token) async {
    try {
      final response =  await dio.get(
        '/institutions/1/visits',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );

      return (response.data as List)
        .map((visit) => Visit.fromJson(visit))
        .toList();
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> createVisit(Visit visit, int family_id, String token) async {
    final data = visit.toJson()..removeWhere((k, v) => v == null);
    try {
      final response = await dio.post(
        '/institutions/1/visit/$family_id',
        data: jsonEncode(data),
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
  
  @override
  Future<bool> createResponseVisit(Response response, int family_id, String token) async {
    try {
      final resp = await dio.post(
        '/institutions/1/visit/${family_id}/response',
        data: response.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return resp.statusCode == 201;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
VisitRepository visitRepository (Ref ref) {
  return VisitRepositoryImpl(dio: ref.watch(dioProvider));
}