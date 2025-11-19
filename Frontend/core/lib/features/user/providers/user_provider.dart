import 'package:core/features/user/application/user_state.dart';
import 'package:core/features/user/data/models/create_user.dart';
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

  Future<void> createUser(CreateUser user) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(userRepositoryProvider).createUser(user);
      await fetchUsers();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        "Email already registered" => "Já existe uma conta com este e-mail",
        "CPF already registered" => "Já existe um cadastro com este CPF",
        _ => msg,
      };
      state = state.copyWith(
        error: translated,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateUser(String email, CreateUser user) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(userRepositoryProvider).updateUser(email, user);
      await fetchUsers();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        "Email already in use" => "Já existe uma conta com este e-mail",
        "CPF already in use" => "Já existe um cadastro com este CPF",
        _ => msg,
      };
      state = state.copyWith(
        error: translated,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
