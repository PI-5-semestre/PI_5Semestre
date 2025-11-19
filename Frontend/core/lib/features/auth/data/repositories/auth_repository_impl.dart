
import 'package:core/features/auth/interface/auth_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:core/features/auth/data/models/user.dart';
import 'package:dio/dio.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<User> login(String email, String password) async{
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password
        },
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? '';
      if (message.toLowerCase().startsWith('invalid credentials')) {
        throw Exception("Credenciais Inválidas");
      }
      throw Exception(message);
    }
  }
}

@riverpod
AuthRepositoryImpl authRepository(Ref ref) {
  return AuthRepositoryImpl(dio: ref.watch(dioProvider));
}