import 'package:core/features/family/application/family_state.dart';
import 'package:core/features/family/data/repositories/family_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_provider.g.dart';

@riverpod
class FamilyController extends _$FamilyController {
  @override
  FamilyState build() => const FamilyState();

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
}
