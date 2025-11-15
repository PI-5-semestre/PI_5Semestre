import 'package:core/models/delivery.dart';
import 'package:core/services/state/base_provider.dart';

class DeliveryProvider extends BaseProvider<List<Delivery>> {
  Future<void> fetchDeliveries() async {
    try {
      setLoading(true);
      notifyListeners();
      await Future.delayed(Duration(seconds: 1));

      setData([
        Delivery(
          name: "Maria Silva",
          status: "Pendente",
          phone: "(11) 98765-4321",
          address: "Rua das Flores, 123 - São Paulo, SP",
          observations: "Idosa, prefere entrega pela manhã.",
        ),
        Delivery(
          name: "João Pereira",
          status: "Entregue",
          phone: "(21) 98888-1111",
          address: "Av. Brasil, 450 - Rio de Janeiro, RJ",
          observations: "Entrega feita pelo vizinho.",
        ),
        Delivery(
          name: "Ana Souza",
          status: "Não Entregue",
          phone: "(31) 97777-2222",
          address: "Rua Afonso Pena, 987 - Belo Horizonte, MG",
          observations: "Família ausente no horário agendado.",
        ),
        Delivery(
          name: "Carlos Oliveira",
          status: "Pendente",
          phone: "(41) 96666-3333",
          address: "Rua XV de Novembro, 55 - Curitiba, PR",
          observations: "Possui 3 filhos pequenos.",
        ),
        Delivery(
          name: "Fernanda Costa",
          status: "Entregue",
          phone: "(51) 95555-4444",
          address: "Av. Ipiranga, 800 - Porto Alegre, RS",
          observations: "Entrega realizada com sucesso.",
        ),
        Delivery(
          name: "Carlos Silva",
          status: "Pendente",
          phone: "(51) 98888-1234",
          address: "Rua dos Andradas, 1500 - Porto Alegre, RS",
          observations: "Cliente não atendido, tentar novamente.",
        ),

        Delivery(
          name: "Mariana Oliveira",
          status: "Não Entregue",
          phone: "(51) 97777-5678",
          address: "Av. Goethe, 450 - Porto Alegre, RS",
          observations: "Endereço incorreto informado pelo cliente.",
        ),

        Delivery(
          name: "João Pereira",
          status: "Não Entregue",
          phone: "(51) 96666-9876",
          address: "Rua Voluntários da Pátria, 320 - Porto Alegre, RS",
          observations: "Saiu para entrega, previsão de chegada em 30 min.",
        ),
      ]);

    } catch (e) {
      setError("Erro ao carregar entregas\n${e.toString()}");
      print("Erro no fetchDeliveries: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void updateStatusObject(Delivery delivery, String newStatus) {
    delivery.status = newStatus;
    notifyListeners();
  }

  Map<String, int> get counts {
    final deliveriesList = data ?? [];
    return {
      "Pendente": deliveriesList.where((d) => d.status == "Pendente").length,
      "Entregue": deliveriesList.where((d) => d.status == "Entregue").length,
      "Não Entregue": deliveriesList
          .where((d) => d.status == "Não Entregue")
          .length,
      "Total": deliveriesList.length,
    };
  }
}
