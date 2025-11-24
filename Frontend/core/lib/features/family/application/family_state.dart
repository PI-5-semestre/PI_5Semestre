import 'package:core/features/family/data/models/family_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_state.freezed.dart';

@freezed
abstract class FamilyState with _$FamilyState {
  const factory FamilyState({
    @Default([]) List<FamilyModel> families,
    @Default([]) List<FamilyModel> filtered,
    @Default(null) String? filterRole,
    @Default({}) Map<String, List<dynamic>> documentsByCpf,
    @Default(false) bool isLoading,
    String? error,
    @Default(null) int? currentDownloadId,

  }) = _FamilyState;
}