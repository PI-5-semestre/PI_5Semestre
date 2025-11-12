
import 'package:core/features/auth/domain/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}