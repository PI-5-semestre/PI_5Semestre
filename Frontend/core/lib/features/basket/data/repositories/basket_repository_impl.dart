import 'package:core/features/basket/data/model/basket_model.dart';
import 'package:core/features/basket/interface/basket_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basket_repository_impl.g.dart';

class BasketRepositoryImpl implements BasketRepository {
  final Dio dio;

  BasketRepositoryImpl({required this.dio});

  @override
  Future<List<BasketModel>> FindAll() async {
    try {
      var response = await dio.get('/institutions/1/baskets/families');
      return (response.data as List)
          .map((stock) => BasketModel.fromJson(stock))
          .toList();
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> create(BasketModel basket, String token) async {
    try {
      var basketJson = basket.toJson();

      var response = await dio.post(
        '/institutions/1/basket',
        data: basketJson,
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
  Future<BasketModel> FindBasketByFamily(int family_id) async {
    try {
      var response = await dio.get('/institutions/1/baskets/${family_id}');
      return response.data.map((stock) => BasketModel.fromJson(stock));
    } on DioException catch (e) {
      final message =
          e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
BasketRepositoryImpl basketRepository(Ref ref) {
  return BasketRepositoryImpl(dio: ref.watch(dioProvider));
  ;
}
