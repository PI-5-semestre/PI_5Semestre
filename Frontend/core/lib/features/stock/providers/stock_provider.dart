import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:core/features/stock/application/stock_state.dart';
import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stock_provider.g.dart';

@riverpod
class StockController extends _$StockController {
  @override
  StockState build() => StockState();

  Future<String> get token async {
    return await ref
            .read(storageServiceProvider.notifier)
            .get<String>('token') ??
        '';
  }

  Future<void> findAll() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final data = await ref.read(stockRepositoryProvider).findAll();
      final onlyPositive = data.where((e) => e.quantity! > 0).toList();
      state = state.copyWith(isLoading: false, stocks: data);

      if (state.filterRole != null) {
        filterByQuantity(state.filterRole!);
      } else {
        state = state.copyWith(filtered: data);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Erro ao carregar o estoque",
      );
    }
  }

  Future<void> add(StockModel stock) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(stockRepositoryProvider).add(stock, await token);
      await findAll();
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  Future<void> update(StockModel stock) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(stockRepositoryProvider).update(stock, await token);
      await findAll();
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  Future<void> delete(StockModel stock) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(stockRepositoryProvider).delete(stock, await token);
      await findAll();
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  Future<void> updateQuantity(StockModel stock) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref
          .read(stockRepositoryProvider)
          .updateQuantity(stock, await token);
      await findAll();
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  void filterByQuantity(String filter) {
    switch (filter) {
      case 'all':
        state = state.copyWith(filtered: state.stocks, filterRole: null);
        break;

      case 'positive':
        final list = state.stocks.where((s) => (s.quantity ?? 0) > 0).toList();
        state = state.copyWith(filtered: list, filterRole: 'positive');
        break;

      case 'zero':
        final list = state.stocks.where((s) => (s.quantity ?? 0) == 0).toList();
        state = state.copyWith(filtered: list, filterRole: 'zero');
        break;

      case 'negative':
        final list = state.stocks.where((s) => (s.quantity ?? 0) < 0).toList();
        state = state.copyWith(filtered: list, filterRole: 'negative');
        break;

      default:
        state = state.copyWith(filtered: state.stocks, filterRole: null);
        break;
    }
  }

  void search(String text) {
    text = text.toLowerCase();

    final list = state.stocks.where((s) {
      final name = (s.name ?? "").toLowerCase();
      final sku = (s.sku ?? "").toLowerCase();
      final qty = (s.quantity?.toString() ?? "").toLowerCase();

      return name.contains(text) || sku.contains(text) || qty.contains(text);
    }).toList();

    state = state.copyWith(filtered: list);
  }
}
