import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/widgets2/stock_card.dart';
import 'package:core/widgets2/skeleton/stock_card_skeleton.dart';
import 'package:core/features/stock/providers/stock_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StockPage extends ConsumerWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockControllerProvider);
    final controller = ref.read(stockControllerProvider.notifier);
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.stocks.isEmpty && !state.isLoading) {
        controller.findAll();
      }
    });

    final stockCounts = [
      state.stocks.length,
      state.stocks.where((s) => (s.quantity ?? 0) == 0).length,
      state.stocks
          .where((s) => (s.quantity ?? 0) > 0 && (s.quantity ?? 0) <= 10)
          .length,
      state.stocks.where((s) => (s.quantity ?? 0) > 10).length,
    ];

    final cards = [
      StatCardSimple("Todos", Icons.inventory, stockCounts[0]),
      StatCardSimple("Críticos", Icons.warning_amber, stockCounts[1]),
      StatCardSimple("OK", Icons.check_circle, stockCounts[2]),
    ];

    final icons = [Icons.inventory, Icons.warning_amber, Icons.check_circle];

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async => controller.findAll(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 8),

              const CardHeader(
                title: 'Controle de Estoque',
                subtitle: 'Gerencie os produtos das cestas básicas',
                colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
                icon: Icons.archive_outlined,
              ),

              const SizedBox(height: 16),

              _buildSearchField(ref),

              const SizedBox(height: 12),

              SegmentedCardSwitcher(
                options: cards,
                icons: icons,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      controller.filterByQuantity('all');
                      break;
                    case 1:
                      controller.filterByQuantity("zero");
                      break;
                    case 2:
                      controller.filterByQuantity('positive');
                      break;
                  }
                },
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Produtos",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (state.isLoading)
                Column(
                  children: List.generate(
                    4,
                    (_) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: StockCardSkeleton(),
                    ),
                  ),
                )
              else
                Column(
                  children: state.filtered.map((stock) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: StockCardModal(stock: stock),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/more/stock/new_stock');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (v) =>
              ref.read(stockControllerProvider.notifier).search(v),
          decoration: const InputDecoration(
            hintText: "Nome, SKU...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class StatCardSimple extends StatelessWidget {
  final String title;
  final IconData icon;
  final int value;

  const StatCardSimple(this.title, this.icon, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const Spacer(),
        Text(
          value.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
