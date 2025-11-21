import 'package:core/features/user/data/models/create_user.dart';
import 'package:core/features/user/interface/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:core/features/auth/data/models/user.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';

part 'user_repository_impl.g.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  final String route;

  UserRepositoryImpl({required this.dio, this.route = '/users/'});

  @override
  Future<List<Account>> fetchUsers() async {
    try {
      final response = await dio.get(
        route
      );

      return (response.data as List)
        .map((json) => Account.fromJson(json))
        .toList();
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<void> createUser(CreateUser user) async {
    try {
      await dio.post(route,data: user.toJson());
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<void> updateUser(String email, CreateUser user) async {
    try {
      await dio.put('$route/$email',data: user.toJson());
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<void> deleteUser(String email) async {
    try {
      await dio.delete('$route/$email');
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
UserRepositoryImpl userRepository (Ref ref) {
  return UserRepositoryImpl(dio: ref.watch(dioProvider));
}