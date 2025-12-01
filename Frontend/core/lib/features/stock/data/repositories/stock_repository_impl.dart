import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/data/repositories/stock_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stock_repository_impl.g.dart';

class StockRepositoryImpl implements StockRepository {
  final Dio dio;

  StockRepositoryImpl({required this.dio});

  @override
  Future<bool> add(StockModel stock, String token) async {
    try {
      var response = await dio.post(
        '/institutions/1/stock',
        data: {'name': stock.name, 'sku': stock.sku},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> delete(StockModel stock, String token) async {
    try {
      final response = await dio.delete(
        '/institutions/1/stock/${stock.sku}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<List<StockModel>> findAll() async {
    try {
      var response = await dio.get('/institutions/1/stock');
      return (response.data as List)
          .map((stock) => StockModel.fromJson(stock))
          .toList();
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> update(StockModel stock, String token) async {
    try {
      final stockJson = stock.toJson();

      final response = await dio.put(
        '/institutions/1/stock/${stockJson['sku']}',
        data: stockJson,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<StockModel> get(String sku) async {
    try {
      var response = await dio.get('/institutions/1/stock/$sku');
      return (response.data as StockModel);
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> updateQuantity(StockModel stock, String token) async {
    try {
      final response = await dio.post(
        '/institutions/1/stock/control',
        data: [
          {'sku': stock.sku, 'quantity': stock.quantity},
        ],
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
StockRepository stockRepository(Ref ref) {
  return StockRepositoryImpl(dio: ref.watch(dioProvider));
}
