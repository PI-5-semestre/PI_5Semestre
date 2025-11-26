import 'package:core/features/viacep/interface/cep_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:core/features/viacep/data/models/cep.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';

part 'cep_repository_impl.g.dart';

class CepRepositoryImpl implements CepRepository {
  final Dio dio;
  CepRepositoryImpl({required this.dio});

  @override
  Future<Cep?> fetchCep(String cep) async {
    try{
      final cleanedCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await dio.get('https://viacep.com.br/ws/$cleanedCep/json/');
      if (response.data["erro"] == true) {
        throw Exception('CEP não encontrado');  
      } else {
        return Cep.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Erro ao buscar CEP');
    }
  }
}

@riverpod
CepRepositoryImpl cepRepositoryImpl(Ref ref) {
  return CepRepositoryImpl(dio: ref.watch(dioProvider));
}