import 'package:core/features/user/application/user_state.dart';
import 'package:core/features/user/data/repositories/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  UserState build() => const UserState();

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final list = await ref.read(userRepositoryProvider).fetchUsers();
      
      state = state.copyWith(
        users: list,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
