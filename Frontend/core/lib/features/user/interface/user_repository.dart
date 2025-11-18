import 'package:core/features/auth/data/models/user.dart';

abstract class UserRepository {
  Future<List<Account>> fetchUsers();
}