import 'package:core/features/viacep/data/repositories/cep_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:core/features/viacep/data/models/cep.dart';

part 'cep_provider.g.dart';

@riverpod
class ViaCep extends _$ViaCep {
  @override
  FutureOr<Cep?> build() => null;

  Future<void> fetchCep(String cep) async {
    state = const AsyncLoading();

    try {
      final cepData = await ref.read(cepRepositoryImplProvider).fetchCep(cep);

      if (ref.mounted) {
        state = AsyncData(cepData);
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}