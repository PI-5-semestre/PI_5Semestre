import 'package:core/features/family/data/repositories/family_repository_impl.dart';
import 'package:core/features/family/application/family_state.dart';
import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_provider.g.dart';

@riverpod
class FamilyController extends _$FamilyController {
  @override
  FamilyState build() => const FamilyState();

    Future<String> get token async {
    return await ref.read(storageServiceProvider.notifier).get<String>('token') ?? '';
  }


  Future<void> fetchFamilies() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await ref.read(familyRepositoryProvider).findAll();
      final onlyActive = data.where((f) => f.active!).toList();
      state = state.copyWith(
        families: onlyActive,
        filtered: onlyActive,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Erro ao buscar famílias");
    }
  }

  void search(String text) {
    text = text.toLowerCase();
    final list = state.families.where((f) {
      return f.name.toLowerCase().contains(text) ||
          f.cpf.contains(text) ||
          f.zip_code.contains(text) ||
          f.neighborhood.toLowerCase().contains(text);
    }).toList();
    state = state.copyWith(filtered: list);
  }

  void filterByRole(String? role) {
    if (role == null) {
      state = state.copyWith(filtered: state.families, filterRole: null);
      return;
    }
    final list = state.families.where((f) => f.situation == role).toList();
    state = state.copyWith(filtered: list, filterRole: role);
  }

  Future<void> createFamily(FamilyModel family) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(familyRepositoryProvider).create(family, await token);
      await fetchFamilies();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        final String text when text.contains("already exists") => "Já existe um cadastro com este CPF",
        _ => msg,
      };
      state = state.copyWith(isLoading: false, error: translated);
    }
  }
}
