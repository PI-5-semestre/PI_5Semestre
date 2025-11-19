import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/user/data/models/create_user.dart';

abstract class UserRepository {
  Future<List<Account>> fetchUsers();
  Future<void> createUser(CreateUser user);
  Future<void> updateUser(String email, CreateUser user);
}