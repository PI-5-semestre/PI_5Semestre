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
      final data = await ref.read(userRepositoryProvider).fetchUsers();
      state = state.copyWith(
        users: data,
        filtered: data,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Erro ao buscar usuários");
    }
  }

  void search(String text) {
    text = text.toLowerCase();
    final list = state.users.where((u) {
      final p = u.profile;
      return u.email.toLowerCase().contains(text) ||
            p?.name.toLowerCase().contains(text) == true ||
            p?.cpf.contains(text) == true ||
            p?.mobile.contains(text) == true;
    }).toList();
    state = state.copyWith(filtered: list);
  }

  void filterByRole(String? role) {
    if (role == null) {
      state = state.copyWith(filtered: state.users, filterRole: null);
      return;
    }
    final list = state.users.where((u) => u.roleName == role).toList();
    state = state.copyWith(filtered: list, filterRole: role);
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

  Future<void> deleteUser(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(userRepositoryProvider).deleteUser(email);
      await fetchUsers();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        final String text when text.contains("not found") => "Usuário não encontrado",
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
