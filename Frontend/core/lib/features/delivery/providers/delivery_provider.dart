
import 'package:core/features/delivery/data/repositories/delivery_repository_impl.dart';
import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:core/features/delivery/application/delivery_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delivery_provider.g.dart';

@riverpod
class DeliveryController extends _$DeliveryController {
  @override
  DeliveryState build() => const DeliveryState();

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedNow = DateTime(now.year, now.month, now.day);
    
    return normalizedDate == normalizedNow;
  }

  Future<String> get token async {
    return await ref.read(storageServiceProvider.notifier).get<String>('token') ?? '';
  }

  Future<void> fetchDeliverys() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = ref.read(deliveryRepositoryProvider);
      final tokenValue = await token;
      final data = await repo.fetchDeliverys(tokenValue);

      final filtered = data.where((d) {
        final activeDelivery = d.active == true;
        final activeFamily = d.family.active == true;
        final correctRole = d.family.situation == "ACTIVE";
        final isTodayDelivery = _isToday(d.delivery_date);

        return activeDelivery && activeFamily && correctRole && isTodayDelivery;
      }).toList();

      state = state.copyWith(
        deliveries: filtered,
        filtered: filtered,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: "Erro ao buscar entregas", isLoading: false);
    }
  }

  void search(String text) {
    text = text.toLowerCase();
    final list = state.deliveries.where((f) {
      return f.family.name.toLowerCase().contains(text) ||
          f.family.cpf.contains(text) ||
          f.family.zip_code.contains(text) ||
          f.family.neighborhood.toLowerCase().contains(text);
    }).toList();
    state = state.copyWith(filtered: list);
  }

  void filterByRole(String? role) {
    if (role == null) {
      state = state.copyWith(filtered: state.deliveries, filterRole: null);
      return;
    }
    final list = state.deliveries.where((f) => f.status == role).toList();
    state = state.copyWith(filtered: list, filterRole: role);
  }
}