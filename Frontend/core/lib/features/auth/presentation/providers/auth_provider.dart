import 'package:core/features/auth/data/auth_repository_impl.dart';
import 'package:core/features/auth/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<User?> build() => null;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      final user = await ref.read(authRepositoryProvider).login(email, password);

      if (ref.mounted) {
        state = AsyncData(user);
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = AsyncError(e, st);
      }
    }
  }

  Future<void> logout() async {
    if (ref.mounted) state = const AsyncData(null);
  }
}
