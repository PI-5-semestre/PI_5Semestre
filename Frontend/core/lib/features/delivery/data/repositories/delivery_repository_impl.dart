import 'package:core/features/delivery/interface/delivery_repository.dart';
import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';

part 'delivery_repository_impl.g.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final Dio dio;

  DeliveryRepositoryImpl({required this.dio});

  @override
  Future<List<DeliveryModel>> fetchDeliverys(String token) async {
    try {
      final response = await dio.get(
        '/institutions/1/deliveries',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return (response.data as List)
          .map((delivery) => DeliveryModel.fromJson(delivery))
          .toList();
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  Future<bool> updateDelivery(Map<String, dynamic> delivery, String token) async {
    try {
      final response = await dio.put(
        '/institutions/1/deliveries/${delivery['id']}',
        data: delivery,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
      );
      return response.statusCode == 200;
    } on DioException catch(e){
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
  
  @override
  Future<bool> attemptsDelivery(Map<String, dynamic> attempts, int delivery_id, String token) async {
    try {
      final response = await dio.post(
        '/institutions/1/deliveries/${delivery_id}/reschedule',
        data: attempts,
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
  
  @override
  Future<bool> createDelivery(Map<String, dynamic> delivery, String token) async {
    try {
      final response = await dio.post(
        '/institutions/1/deliveries',
        data: delivery,
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }
}

@riverpod
DeliveryRepositoryImpl deliveryRepository(Ref ref) {
  return DeliveryRepositoryImpl(dio: ref.watch(dioProvider));
}