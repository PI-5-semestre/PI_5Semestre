import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user.freezed.dart';
part 'create_user.g.dart';


@freezed
abstract class CreateUser with _$CreateUser{
  factory CreateUser({
    required String email,
    required String name,
    required String cpf,
    required String mobile,
    required String password,
    // ignore: non_constant_identifier_names
    String? account_type,
    // ignore: non_constant_identifier_names
    required int institution_id,
  }) = _CreateUser;

  factory CreateUser.fromJson(Map<String, dynamic> json) => _$CreateUserFromJson(json);
}