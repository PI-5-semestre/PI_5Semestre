import 'package:core/features/visits/data/models/visits.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_state.freezed.dart';

@freezed
abstract class VisitState with _$VisitState {
  const factory VisitState({
    @Default([]) List<Visit> visities,
    @Default([]) List<Visit> filtered,
    @Default(null) String? filterRole,
    @Default(false) bool isLoading,
    int? selectedIndex,
    String? error,

  }) = _VisitState;
}