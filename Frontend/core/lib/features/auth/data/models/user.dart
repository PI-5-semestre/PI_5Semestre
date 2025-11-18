import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    required Account account,
    required String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class Account with _$Account {
  factory Account({
    required int id,
    required String created,
    required String modified,
    required bool active,
    required String email,
    // ignore: non_constant_identifier_names
    required String account_type,
    // ignore: non_constant_identifier_names
    required int institution_id,
    required Profile profile,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  factory Profile({
    required int id,
    required String name,
    required String cpf,
    required String mobile,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}