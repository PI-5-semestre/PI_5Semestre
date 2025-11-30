import 'dart:convert';

import 'package:core/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/shared_preferences/service/storage_service.dart';
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

      await ref.read(storageServiceProvider.notifier).set('token', user.token);
      await ref.read(storageServiceProvider.notifier).set('user', jsonEncode(user.account));

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
    await ref.read(storageServiceProvider.notifier).remove('token');
    await ref.read(storageServiceProvider.notifier).remove('user');
  }
}
