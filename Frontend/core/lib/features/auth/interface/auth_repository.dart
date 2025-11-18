
import 'package:core/features/auth/data/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}