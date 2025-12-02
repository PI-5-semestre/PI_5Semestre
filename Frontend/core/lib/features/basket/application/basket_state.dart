import 'package:core/features/basket/data/model/basket_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_state.freezed.dart';

@freezed
abstract class BasketState with _$BasketState {
  const factory BasketState({
    @Default([]) List<BasketModel> baskets,
    @Default([]) List<BasketModel> filtered,
    @Default(null) String? filterRole,
    @Default(false) bool isLoading,
    String? error,
  }) = _BasketState;
}
