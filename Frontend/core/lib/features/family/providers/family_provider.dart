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

  Future<void> updateFamily(FamilyModel user) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(familyRepositoryProvider).update(user, await token);
      await fetchFamilies();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
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

  Future<void> deleteFamily(String cpf) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(familyRepositoryProvider).delete(cpf, await token);
      await fetchFamilies();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        final String text when text.contains("found in this institution") => "Família não encontrada",
        _ => msg,
      };
      state = state.copyWith(
        error: translated,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> uploadDocument({
    required String cpf,
    required String docType,
    required String filePath,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(familyRepositoryProvider).uploadDocument(
        cpf: cpf,
        docType: docType,
        filePath: filePath,
      );
      await fetchFamilies();
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(error: msg);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<dynamic>> fetchDocuments(String cpf) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref.read(familyRepositoryProvider).getDocuments(cpf);

      state = state.copyWith(
        documentsByCpf: {
          ...state.documentsByCpf,
          cpf: result,
        },
      );

      return result;
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(error: msg);
      return [];
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> downloadDocument(String cpf, int documentId) async {
    state = state.copyWith(
      isLoading: true, 
      error: null,
      currentDownloadId: documentId,
    );
    
    try {
      await ref.read(familyRepositoryProvider).downloadDocument(cpf, documentId);
      
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(error: msg);
    } finally {
      state = state.copyWith(
        isLoading: false,
        currentDownloadId: null,
      );
    }
  }
}
