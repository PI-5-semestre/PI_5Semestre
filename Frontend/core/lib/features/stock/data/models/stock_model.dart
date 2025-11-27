import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';
part 'stock_model.g.dart';

@freezed
abstract class StockModel with _$StockModel {
  const factory StockModel({
    int? id,
    DateTime? created,
    DateTime? modified,
    bool? active,
    // ignore: non_constant_identifier_names
    int? institution_id,
    String? name,
    String? sku,
    int? quantity,
  }) = _StockModel;

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
}
