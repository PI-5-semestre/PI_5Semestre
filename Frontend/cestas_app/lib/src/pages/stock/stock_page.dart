import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/services/state/stock_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/card_info.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = StockProvider();
        provider.fetchStocks();
        return provider;
      },
      child: const _StockView(),
    );
  }
}

class _StockView extends StatefulWidget {
  const _StockView({super.key});

  @override
  State<_StockView> createState() => _StockViewState();
}

class _StockViewState extends State<_StockView> {
  static const double _pagePadding = 16;
  static const double _spacing = 16;
  int itemsToShow = 10;

  String selectedStatus = "Todos";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    final stocks = provider.data ?? [];
    final List<StockModel> mockStocks = [
      StockModel(id: 1, name: "Arroz Tipo 1", sku: "ARZ-001", quantity: 25),
      StockModel(id: 2, name: "Feijão Carioca", sku: "FEI-002", quantity: 8),
      StockModel(
        id: 3,
        name: "Macarrão Espaguete 500g",
        sku: "MAC-003",
        quantity: 40,
      ),
      StockModel(
        id: 4,
        name: "Óleo de Soja 900ml",
        sku: "OLE-004",
        quantity: 12,
      ),
      StockModel(
        id: 5,
        name: "Açúcar Refinado 1kg",
        sku: "ACU-005",
        quantity: 0,
      ),
      StockModel(id: 6, name: "Sal Refinado 1kg", sku: "SAL-006", quantity: 18),
      StockModel(id: 7, name: "Café Torrado 500g", sku: "CAF-007", quantity: 7),
      StockModel(
        id: 8,
        name: "Farinha de Trigo 1kg",
        sku: "FAR-008",
        quantity: 32,
      ),
      StockModel(
        id: 9,
        name: "Molho de Tomate 300g",
        sku: "MOL-009",
        quantity: 11,
      ),
      StockModel(
        id: 10,
        name: "Biscoito Cream Cracker",
        sku: "BIS-010",
        quantity: 15,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
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
              //_buildButton(context),
            ],
          ),
          const SizedBox(height: _spacing),
          InfoCard(
            title: "Estoque Atual",
            color: const Color(0xFF155DFC),
            icon: Icons.today,
            iconColor: Colors.white,
            iconBackground: Colors.white.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_buildStatCards(counts),
                const SizedBox(height: _spacing),
                Row(children: [Expanded(flex: 2, child: _buildSearchField())]),
                const SizedBox(height: _spacing),
                _buildList(mockStocks),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/more/stock/new_stock');
        },
        child: Icon(Icons.add),
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

  Widget _buildList(List<StockModel> stocks) {
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
                          stock.name ?? "",
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
                            stock.sku ?? "—",
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
              onPressed: () {
                setState(() {
                  itemsToShow += 5;
                });
              },
              child: const Text("Carregar mais"),
            ),
          ),
      ],
    );
  }

  // Widget _buildTable(List stocks) {
  //   if (stocks.isEmpty) {
  //     return const Center(
  //       child: Padding(
  //         padding: EdgeInsets.all(32),
  //         child: Text("Estoque Vazio", style: TextStyle(fontSize: 16)),
  //       ),
  //     );
  //   }

  //   final availableHeight =
  //       MediaQuery.of(context).size.height - kToolbarHeight - 350;

  //   return ConstrainedBox(
  //     constraints: BoxConstraints(minHeight: availableHeight),
  //     child: LayoutBuilder(
  //       builder: (context, constraints) {
  //         return SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: SizedBox(
  //             width: constraints.maxWidth,
  //             child: DataTable(
  //               columnSpacing: 12,
  //               headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
  //               dataRowMinHeight: 48,
  //               dataRowMaxHeight: 56,
  //               columns: const [
  //                 DataColumn(label: Text("SKU")),
  //                 DataColumn(label: Text("Nome")),
  //                 DataColumn(label: Text("Quantidade")),
  //               ],
  //               rows: stocks.map((stock) {
  //                 return DataRow(
  //                   cells: [
  //                     DataCell(Text(stock.sku)),
  //                     DataCell(Text(stock.name)),
  //                     DataCell(Text(stock.quantity.toString())),
  //                   ],
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildStatCards(Map<String, int> counts) {

  //   ];

  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       final maxWidth = constraints.maxWidth;
  //       final maxColumns = maxWidth > 1300
  //           ? 5
  //           : maxWidth > 1200
  //           ? 4
  //           : maxWidth > 800
  //           ? 3
  //           : maxWidth > 500
  //           ? 2
  //           : 1;

  //       final columns = cards.length < maxColumns ? cards.length : maxColumns;
  //       final totalSpacing = _spacing * (columns - 1);
  //       final cardWidth = (maxWidth - totalSpacing) / columns;

  //       return Wrap(
  //         spacing: _spacing,
  //         runSpacing: _spacing,
  //         children: cards
  //             .map((c) => SizedBox(width: cardWidth, child: c))
  //             .toList(),
  //       );
  //     },
  //   );
  // }

  // Widget _buildButton(BuildContext context) {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       Navigator.of(
  //         context,
  //       ).push(MaterialPageRoute(builder: (_) => NewStockPage()));
  //     },
  //     icon: const Icon(Icons.add, color: Colors.white),
  //     label: const Text(
  //       "Adicionar produto",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: const Color(0xFF00c64f),
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //     ),
  //   );
  // }
}
