import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_state.freezed.dart';

@freezed
abstract class DeliveryState with _$DeliveryState {
  const factory DeliveryState({
    @Default([]) List<DeliveryModel> deliveries,
    @Default([]) List<DeliveryModel> filtered,
    @Default(null) String? filterRole,
    @Default(false) bool isLoading,
    String? error,
  }) = _DeliveryState;
}