import 'package:core/features/stock/data/models/stock_model.dart';

abstract interface class StockRepository {
  Future<List<StockModel>> findAll();
  Future<StockModel> get(String sku);
  Future<bool> add(StockModel stock, String token);
  Future<bool> update(StockModel stock, String token);
  Future<bool> delete(StockModel stock, String token);
}
