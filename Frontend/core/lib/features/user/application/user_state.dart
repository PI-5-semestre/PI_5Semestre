import 'package:core/features/auth/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default([]) List<Account> users,
    @Default(false) bool isLoading,
    String? error,
  }) = _UserState;
}