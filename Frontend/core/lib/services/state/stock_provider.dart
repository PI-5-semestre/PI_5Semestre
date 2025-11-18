import 'package:core/models/delivery.dart';
import 'package:core/models/stock.dart';
import 'package:core/services/state/base_provider.dart';

class StockProvider extends BaseProvider<List<Stock>> {
  Future<void> fetchStocks() async {
    try {
      setLoading(true);
      notifyListeners();

      await Future.delayed(Duration(seconds: 1));

      setData([
        Stock(name: "Feijão Preto", cests: 20, minStock: 15, quantity: 125),
        Stock(name: "Óleo de Soja", cests: 10, minStock: 8, quantity: 12),
        Stock(name: "Açúcar", cests: 50, minStock: 40, quantity: 55),
        Stock(name: "Café", cests: 15, minStock: 10, quantity: 18),
        Stock(name: "Macarrão", cests: 25, minStock: 22, quantity: 30),
        Stock(name: "Leite em Pó", cests: 5, minStock: 3, quantity: 7),
        Stock(name: "Farinha de Trigo", cests: 35, minStock: 30, quantity: 42),
        Stock(name: "Sal", cests: 8, minStock: 5, quantity: 10),
        Stock(name: "Biscoito", cests: 45, minStock: 35, quantity: 50),
      ]);
    } catch (e) {
      setError("Erro ao carregar estoques\n${e.toString()}");
      print("Erro no fetchStocks: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Map<String, int> get counts {
    final List<Stock> stockList = data ?? [];
    return {
      "Produtos Ativos": stockList.length,
      "Estoque Baixo": stockList.where((d) => d.quantity < 10).length,
      "Estoque Alto": stockList.where((d) => d.quantity > 100).length,
      "Sem Estoque": stockList.where((d) => d.quantity == 0).length,
    };
  }
}
