import 'package:core/features/visits/application/visit_state.dart';
import 'package:core/features/visits/data/models/visits.dart';
import 'package:core/features/visits/data/repositories/visit_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visit_provider.g.dart';

@riverpod
class VisitController extends _$VisitController {
  @override
  VisitState build() => VisitState();

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedNow = DateTime(now.year, now.month, now.day);
    
    return normalizedDate == normalizedNow;
  }

  Future<void> fetchVisits() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await ref.read(visitRepositoryProvider).fetchVisits();

      final onlyActive = data.where((v) {
        final activeVisit = v.active == true;
        final isTodayDelivery = _isToday(DateTime.parse(v.visit_at));

        return activeVisit && isTodayDelivery;
      }).toList();

      state = state.copyWith(
        visities: onlyActive,
        filtered: onlyActive,
        isLoading: false
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Erro ao buscar visitas");
    }
  }

  void search(String text) {
    text = text.toLowerCase();
    final list = state.visities.where((v) {
      return v.family!.name.toLowerCase().contains(text) ||
          v.family!.cpf.contains(text) ||
          v.family!.zip_code.contains(text) ||
          v.family!.neighborhood.toLowerCase().contains(text);
    }).toList();
    state = state.copyWith(filtered: list);
  }

  void filterByRole(String? role) {
    if (role == null) {
      state = state.copyWith(filtered: state.visities, filterRole: null);
      return;
    }

    final list = state.visities.where((v) {
      final status = v.response?.status;

      return role == 'PENDING'
          ? (status == 'PENDING' || status == null)
          : status == role;
    }).toList();

    state = state.copyWith(filtered: list, filterRole: role);
  }


  Future<void> createVisit(Visit visit, int family_id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(visitRepositoryProvider).createVisit(visit, family_id);

      if (!ref.mounted) return;

    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      if (!ref.mounted) return;

      state = state.copyWith(error: msg);
    } finally {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> createResponseVisit(Response response) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(visitRepositoryProvider).createResponseVisit(response);

      if (!ref.mounted) return;

    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      String translated = switch (msg) {
        final String text when text.contains("Visitation with id") => "Visita não encontrada",
        final String text when text.contains("InstitutionVisitationResultType") => "Status selecionado é inválido",
        _ => msg,
      };
      if (!ref.mounted) return;

      state = state.copyWith(error: translated);
    } finally {
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false);
    }
  }
}