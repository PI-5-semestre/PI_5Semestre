import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_state.freezed.dart';

@freezed
abstract class StockState with _$StockState {
  const factory StockState({
    @Default([]) List<StockModel> stocks,
    @Default([]) List<StockModel> filtered,
    @Default(null) String? filterRole,
    @Default(false) bool isLoading,
    String? error,
  }) = _StockState;
}
