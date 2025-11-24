
import 'package:core/features/delivery/data/models/delivery.dart';

abstract class DeliveryRepository {
  Future<List<DeliveryModel>> fetchDeliverys(String token);
}