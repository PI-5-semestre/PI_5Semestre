import 'package:core/features/basket/application/basket_state.dart';
import 'package:core/features/basket/data/model/basket_model.dart';
import 'package:core/features/basket/data/repositories/basket_repository_impl.dart';
import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basket_provider.g.dart';

@riverpod
class BasketController extends _$BasketController {
  @override
  build() => BasketState();

  Future<String> get token async {
    return await ref
            .read(storageServiceProvider.notifier)
            .get<String>('token') ??
        '';
  }

  Future<void> create(
    FamilyModel family,
    Map<StockModel, int> selectedProducts,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final basket = BasketModel(
        familyId: family.id,
        type: "G",
        products: selectedProducts.entries.map((entry) {
          final product = entry.key;
          final qty = entry.value;

          return BasketProductModel(productSku: product.sku, quantity: qty);
        }).toList(),
      );

      await ref.read(basketRepositoryProvider).create(basket, await token);
      //await findAll();
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: message);
    }
  }
}
