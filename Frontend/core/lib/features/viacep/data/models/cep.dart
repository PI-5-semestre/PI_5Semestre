import 'package:freezed_annotation/freezed_annotation.dart';

part 'cep.freezed.dart';
part 'cep.g.dart';

@freezed
abstract class Cep with _$Cep {
  factory Cep({
    required String cep,
    required String logradouro,
    required String complemento,
    required String bairro,
    required String localidade,
    required String uf
  }) = _Cep;

  factory Cep.fromJson(Map<String, dynamic> json) => _$CepFromJson(json);
}