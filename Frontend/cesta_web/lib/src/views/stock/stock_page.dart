import 'package:core/features/stock/application/stock_state.dart';
import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/providers/stock_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<StockPage> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  static const double _pagePadding = 16;
  static const double _spacing = 16;

  int itemsToShow = 10;
  String selectedStatus = "Todos";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(stockControllerProvider);

      if (state.stocks.isEmpty && !state.isLoading) {
        ref.read(stockControllerProvider.notifier).findAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockControllerProvider);
    final controller = ref.read(stockControllerProvider.notifier);
    final theme = Theme.of(context);

    if (!state.isLoading && state.error != null && state.stocks.isEmpty) {
      return Center(child: Text("Não foi possível carregar as famílias"));
    }

    // final List<StockModel> mockStocks = [
    //   StockModel(id: 1, name: "Arroz Tipo 1", sku: "ARZ-001", quantity: 25),
    //   StockModel(id: 2, name: "Feijão Carioca", sku: "FEI-002", quantity: 8),
    //   StockModel(
    //     id: 3,
    //     name: "Macarrão Espaguete 500g",
    //     sku: "MAC-003",
    //     quantity: 40,
    //   ),
    //   StockModel(
    //     id: 4,
    //     name: "Óleo de Soja 900ml",
    //     sku: "OLE-004",
    //     quantity: 12,
    //   ),
    //   StockModel(
    //     id: 5,
    //     name: "Açúcar Refinado 1kg",
    //     sku: "ACU-005",
    //     quantity: 0,
    //   ),
    //   StockModel(id: 6, name: "Sal Refinado 1kg", sku: "SAL-006", quantity: 18),
    //   StockModel(id: 7, name: "Café Torrado 500g", sku: "CAF-007", quantity: 7),
    //   StockModel(
    //     id: 8,
    //     name: "Farinha de Trigo 1kg",
    //     sku: "FAR-008",
    //     quantity: 32,
    //   ),
    //   StockModel(
    //     id: 9,
    //     name: "Molho de Tomate 300g",
    //     sku: "MOL-009",
    //     quantity: 11,
    //   ),
    //   StockModel(
    //     id: 10,
    //     name: "Biscoito Cream Cracker",
    //     sku: "BIS-010",
    //     quantity: 15,
    //   ),
    // ];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(_pagePadding),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: CardHeader(
                  title: 'Controle de estoque',
                  subtitle: 'Gerencie os produtos das cestas básicas',
                  colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
                  icon: Icons.archive_outlined,
                ),
              ),
              const SizedBox(width: _spacing),
            ],
          ),
          const SizedBox(height: _spacing),

          InfoCard(
            title: "Estoque Atual",
            color: const Color(0xFF155DFC),
            icon: Icons.today,
            iconColor: Colors.white,
            iconBackground: Colors.white54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _spacing),
                Row(children: [Expanded(flex: 2, child: _buildSearchField())]),
                const SizedBox(height: _spacing),
                _buildList(state.stocks, controller, state),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/stock/new_stock');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) => setState(() => searchQuery = value),
      decoration: InputDecoration(
        hintText: "Buscar produto...",
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildList(
    List<StockModel> stocks,
    StockController controller,
    StockState state,
  ) {
    final visibleStocks = stocks.take(itemsToShow).toList();

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleStocks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final stock = visibleStocks[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (stock.name == null || stock.name!.trim().isEmpty)
                              ? "[Produto não encontrado]"
                              : stock.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            (stock.sku == null || stock.sku!.trim().isEmpty)
                                ? "NE — 000"
                                : stock.sku!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.inventory_2,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 6),

                        Text(
                          "Quantidade: ${stock.quantity}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // ação de editar
                              },
                              icon: const Icon(Icons.tune_outlined),
                              color: Colors.blue.shade600,
                              tooltip: "Editar",
                            ),
                            IconButton(
                              onPressed: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Confirmar exclusão"),
                                      content: Text(
                                        "Tem certeza que deseja excluir o produto ?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "Excluir",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (shouldDelete == true) {
                                  controller.delete(
                                    stock,
                                  ); // <-- agora só exclui se confirmar
                                }
                              },

                              icon: const Icon(Icons.delete_forever_rounded),
                              color: Colors.red.shade400,
                              tooltip: "Excluir",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (itemsToShow < stocks.length)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ElevatedButton(
              onPressed: () => setState(() => itemsToShow += 5),
              child: const Text("Carregar mais"),
            ),
          ),
      ],
    );
  }
}
