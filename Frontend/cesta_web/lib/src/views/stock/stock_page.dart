import 'package:cesta_web/src/views/delivery/new_delivery_page.dart';
import 'package:cesta_web/src/views/stock/new_stock_page.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:core/services/state/stock_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/card_info.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';
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
  
  String selectedStatus = "Todos";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    final stocks = provider.data ?? [];
    final counts = provider.counts.isNotEmpty
        ? provider.counts
        : {
            "Produtos Ativos": 0,
            "Estoque Baixo": 0,
            "Estoque Alto": 0,
            "Sem Estoque": 0,
          };

    final filteredDeliveries = stocks.where((d) {
      final matchesStatus =
          selectedStatus == "Todos" || d.status == selectedStatus;
      final matchesSearch = d.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesStatus && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : (provider.error != null && provider.error!.isNotEmpty)
              ? Center(child: Text(provider.error!))
              : ListView(
                  padding: const EdgeInsets.all(_pagePadding),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: CardHeader(
                            icon: Icons.archive_outlined,
                            colors: [Color(0xFF00c64f), Color(0xFF00a73e)],
                            title: "Controle de estoque",
                            subtitle: "Gerencie os produtos das cestas básicas",
                          ),
                        ),
                        const SizedBox(width: _spacing),
                        _buildButton(context),
                      ],
                    ),
                    const SizedBox(height: _spacing),

                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          onChanged: (value) {
                            setState(() => searchQuery = value);
                          },
                          decoration: const InputDecoration(
                            hintText: "Buscar produto...",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: _spacing),
                    InfoCard(
                      title: "Estoque Atual",
                      color: const Color(0xFF00a73e),
                      icon: Icons.today,
                      iconColor: Colors.white,
                      iconBackground: Colors.white.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatCards(counts),
                          const SizedBox(height: _spacing),
                          _buildTable(filteredDeliveries),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildTable(List stocks) {
    if (stocks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            "Estoque Vazio",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final availableHeight =
        MediaQuery.of(context).size.height - kToolbarHeight - 350;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: availableHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: constraints.maxWidth,
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                columns: const [
                  DataColumn(label: Text("Nome")),
                  DataColumn(label: Text("Cestas")),
                  DataColumn(label: Text("Estoque Mínimo")),
                  DataColumn(label: Text("Quantidade")),
                ],
                rows: stocks.map((delivery) {
                  return DataRow(
                    cells: [
                      DataCell(Text(delivery.name)),
                      DataCell(Text(delivery.cests.toString())),
                      DataCell(Text(delivery.minStock.toString())),
                      DataCell(Text(delivery.quantity.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCards(Map<String, int> counts) {
    final cards = [
      StatCard(
        icon: Icons.inventory_2,
        colors: [Color(0xFF3d89ff), Color(0xFF165ffc)],
        title: "Cestas Disponíveis",
        value: "15",
      ),
      StatCard(
        icon: Icons.show_chart,
        colors: [Color(0xFF00c64f), Color(0xFF00a73e)],
        title: "Produtos Ativos",
        value: counts["Produtos Ativos"].toString(),
      ),
      StatCard(
        icon: Icons.warning_amber_rounded,
        colors: [Color(0xFFecab00), Color(0xFFd69417)],
        title: "Estoque Baixo",
        value: counts["Estoque Baixo"].toString(),
      ),
      StatCard(
        icon: Icons.error,
        colors: [Color(0xFFf82632), Color(0xFFe90012)],
        title: "Sem Estoque",
        value: counts["Sem Estoque"].toString(),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxColumns = maxWidth > 1300
            ? 5
            : maxWidth > 1200
                ? 4
                : maxWidth > 800
                    ? 3
                    : maxWidth > 500
                        ? 2
                        : 1;

        final columns = cards.length < maxColumns ? cards.length : maxColumns;
        final totalSpacing = _spacing * (columns - 1);
        final cardWidth = (maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: cards
              .map((c) => SizedBox(width: cardWidth, child: c))
              .toList(),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => NewStockPage()),
        );
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        "Adicionar produto",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00c64f),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
