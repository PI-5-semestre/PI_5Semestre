
import 'package:core/features/viacep/data/models/cep.dart';

abstract class CepRepository {
  Future<Cep?> fetchCep(String cep);
}