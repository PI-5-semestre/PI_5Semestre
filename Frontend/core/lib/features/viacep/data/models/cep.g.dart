// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cep _$CepFromJson(Map<String, dynamic> json) => _Cep(
  cep: json['cep'] as String,
  logradouro: json['logradouro'] as String,
  complemento: json['complemento'] as String,
  bairro: json['bairro'] as String,
  localidade: json['localidade'] as String,
  uf: json['uf'] as String,
);

Map<String, dynamic> _$CepToJson(_Cep instance) => <String, dynamic>{
  'cep': instance.cep,
  'logradouro': instance.logradouro,
  'complemento': instance.complemento,
  'bairro': instance.bairro,
  'localidade': instance.localidade,
  'uf': instance.uf,
};
