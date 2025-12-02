import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/providers/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/widgets2/skeleton/product_card_skeleton.dart';
import 'package:core/features/basket/providers/basket_provider.dart';

class CreateBasketPage extends ConsumerStatefulWidget {
  final FamilyModel family;

  const CreateBasketPage({super.key, required this.family});

  @override
  ConsumerState<CreateBasketPage> createState() => _CreateBasketPageState();
}

class _CreateBasketPageState extends ConsumerState<CreateBasketPage> {
  final TextEditingController searchController = TextEditingController();
  final Map<StockModel, int> selectedProducts = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stockControllerProvider.notifier).findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockState = ref.watch(stockControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          final basketState = ref.watch(basketControllerProvider);

          return FloatingActionButton(
            onPressed: (selectedProducts.isEmpty || basketState.isLoading)
                ? null
                : () async {
                    final controller = ref.read(
                      basketControllerProvider.notifier,
                    );

                    await controller.create(widget.family, selectedProducts);

                    final error = ref.read(basketControllerProvider).error;

                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cesta criada com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  },
            child: basketState.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.check),
          );
        },
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.family.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.outline,
            ),
          ),

          const SizedBox(height: 12),

          /// Busca
          TextField(
            controller: searchController,
            onChanged: (value) {
              ref.read(stockControllerProvider.notifier).search(value);
            },
            decoration: InputDecoration(
              hintText: "Buscar produto...",
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// Produtos disponíveis
          Text(
            "Produtos disponíveis",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          if (stockState.isLoading)
            Column(
              children: List.generate(
                6, // quantidade de skeletons
                (_) => const ProductCardSkeleton(),
              ),
            )
          else
            ..._buildProductList(stockState.filtered),

          const SizedBox(height: 24),

          /// Produtos selecionados
          if (selectedProducts.isNotEmpty) ...[
            Text(
              "Selecionados (${selectedProducts.length})",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._buildSelectedProducts(),
          ],

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  List<Widget> _buildProductList(List<StockModel> list) {
    final filtered = list.where((p) => (p.quantity ?? 0) > 0).toList();

    if (filtered.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              "Nenhum produto disponível.",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      ];
    }

    return filtered.map((product) {
      final isAdded = selectedProducts.containsKey(product);

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedProducts[product] = 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                /// Nome + SKU
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? "Sem nome",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Estoque: ${product.quantity}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  isAdded ? Icons.check_circle : Icons.add_circle_outline,
                  color: isAdded ? Colors.green : null,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildSelectedProducts() {
    return selectedProducts.entries.map((entry) {
      final product = entry.key;
      final qty = entry.value;
      final maxQty = product.quantity ?? 1;

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              /// Nome
              Expanded(
                child: Text(
                  product.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              /// Botões
              Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    enabled: qty > 1,
                    onTap: () {
                      setState(() => selectedProducts[product] = qty - 1);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("$qty", style: const TextStyle(fontSize: 15)),
                  ),

                  _qtyButton(
                    icon: Icons.add,
                    enabled: qty < maxQty,
                    onTap: () {
                      setState(() => selectedProducts[product] = qty + 1);
                    },
                  ),
                ],
              ),

              /// Delete
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  setState(() => selectedProducts.remove(product));
                },
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _qtyButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: enabled ? Colors.blue.shade50 : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: enabled ? Colors.blue : Colors.grey),
      ),
    );
  }
}
