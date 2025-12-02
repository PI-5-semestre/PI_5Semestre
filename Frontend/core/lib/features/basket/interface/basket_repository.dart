import 'package:core/features/basket/data/model/basket_model.dart';

abstract interface class BasketRepository {
  Future<bool> create(BasketModel basket, String token);
}
