
import 'package:core/features/delivery/data/models/delivery.dart';

abstract class DeliveryRepository {
  Future<List<DeliveryModel>> fetchDeliverys(String token);
  Future<bool> createDelivery(Map<String, dynamic> delivery, String token);
  Future<bool> updateDelivery(Map<String, dynamic> delivery, String token);
  Future<bool> attemptsDelivery(Map<String, dynamic> delivery, int delivery_id, String token);
}