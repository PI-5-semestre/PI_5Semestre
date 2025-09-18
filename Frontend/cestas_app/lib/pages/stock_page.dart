import 'package:flutter/material.dart';
import 'package:cestas_app/widgets/app_drawer.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  String searchTerm = "";
  String selectedCategory = "all";

  final List<Product> mockProducts = [
    Product(
      id: "1",
      name: "Arroz Branco",
      category: "Grãos",
      currentStock: 150,
      stockPerBasket: 2,
      possibleBaskets: 75,
      minStock: 30,
      unit: "kg",
      status: "in-stock",
    ),
    Product(
      id: "2",
      name: "Feijão Carioca",
      category: "Grãos",
      currentStock: 120,
      stockPerBasket: 1,
      possibleBaskets: 120,
      minStock: 25,
      unit: "kg",
      status: "in-stock",
    ),
    Product(
      id: "3",
      name: "Óleo de Soja",
      category: "Óleos",
      currentStock: 80,
      stockPerBasket: 1,
      possibleBaskets: 80,
      minStock: 15,
      unit: "l",
      status: "in-stock",
    ),
    Product(
      id: "4",
      name: "Farinha de Trigo",
      category: "Grãos",
      currentStock: 15,
      stockPerBasket: 1,
      possibleBaskets: 15,
      minStock: 20,
      unit: "kg",
      status: "low-stock",
    ),
  ];

  final Map<String, int> stats = {
    "availableBaskets": 15,
    "activeProducts": 8,
    "lowStock": 1,
    "outOfStock": 0,
  };

  double getStockPercentage(int current, int min) {
    final maxStock = min * 3;
    final v = current / maxStock;
    if (v < 0) return 0;
    if (v > 1) return 1;
    return v;
  }

  Color getProgressColor(double percent) {
    if (percent >= 0.6) return Colors.green;
    if (percent >= 0.3) return Colors.yellow[700]!;
    return Colors.red;
  }

  Color getStockLevelColor(double percent) {
    if (percent >= 0.6) return Colors.green[700]!;
    if (percent >= 0.3) return Colors.yellow[700]!;
    return Colors.red[700]!;
  }

  @override
  Widget build(BuildContext context) {
    final lowStockProducts = mockProducts
        .where((p) => p.status == "low-stock")
        .toList();

    final filteredProducts = mockProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchTerm.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == "all" || product.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isSmall = w < 600;
        final isMedium = w >= 600 && w < 1024;
        final statCols = isSmall ? 1 : (isMedium ? 2 : 4);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(),
          drawer: const AppDrawer(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (isSmall)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Controle de Estoque",
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Gerencie os produtos das cestas básicas",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text("Novo Produto"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Controle de Estoque",
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Gerencie os produtos das cestas básicas",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text("Novo Produto"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: statCols,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3.2,
                  ),
                  children: [
                    StatCard(
                      title: "Cestas Disponíveis",
                      value: stats["availableBaskets"]!,
                      icon: Icons.shopping_cart_outlined,
                      accentColor: Colors.blue,
                    ),
                    StatCard(
                      title: "Produtos Ativos",
                      value: stats["activeProducts"]!,
                      icon: Icons.trending_up_rounded,
                      accentColor: Theme.of(context).colorScheme.primary,
                    ),
                    StatCard(
                      title: "Estoque Baixo",
                      value: stats["lowStock"]!,
                      icon: Icons.warning_amber_rounded,
                      accentColor: Colors.orange,
                    ),
                    StatCard(
                      title: "Sem Estoque",
                      value: stats["outOfStock"]!,
                      icon: Icons.cancel_outlined,
                      accentColor: Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if (lowStockProducts.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      border: Border.all(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Atenção: Produtos Precisam de Reposição",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...lowStockProducts.map(
                          (p) => Text(
                            "${p.name} (${p.currentStock} ${p.unit})",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                if (isSmall)
                  Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Buscar produtos...",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => searchTerm = value.trim()),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: "all",
                                  child: Text("Todas as categorias"),
                                ),
                                DropdownMenuItem(
                                  value: "Grãos",
                                  child: Text("Grãos"),
                                ),
                                DropdownMenuItem(
                                  value: "Óleos",
                                  child: Text("Óleos"),
                                ),
                              ],
                              onChanged: (val) =>
                                  setState(() => selectedCategory = val!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Buscar produtos...",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) =>
                              setState(() => searchTerm = value.trim()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 220,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: "all",
                                  child: Text("Todas as categorias"),
                                ),
                                DropdownMenuItem(
                                  value: "Grãos",
                                  child: Text("Grãos"),
                                ),
                                DropdownMenuItem(
                                  value: "Óleos",
                                  child: Text("Óleos"),
                                ),
                              ],
                              onChanged: (val) =>
                                  setState(() => selectedCategory = val!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // ===== LISTA DE PRODUTOS =====
                Column(
                  children: filteredProducts.map((product) {
                    final percent = getStockPercentage(
                      product.currentStock,
                      product.minStock,
                    );

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Chip(
                                        label: Text(product.category),
                                        backgroundColor: Colors.grey
                                            .withOpacity(0.15),
                                      ),
                                      Chip(
                                        label: const Text("Em estoque"),
                                        backgroundColor:
                                            product.status == "in-stock"
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Colors.red,
                                        labelStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3.4,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 4,
                                  ),
                              children: [
                                ProductInfo(
                                  "Estoque atual",
                                  "${product.currentStock} ${product.unit}",
                                ),
                                ProductInfo(
                                  "Por cesta",
                                  "${product.stockPerBasket} ${product.unit}",
                                ),
                                ProductInfo(
                                  "Cestas possíveis",
                                  "${product.possibleBaskets}",
                                ),
                                ProductInfo(
                                  "Estoque mínimo",
                                  "${product.minStock} ${product.unit}",
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Nível de estoque",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${(percent * 100).round()}%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getStockLevelColor(percent),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: LinearProgressIndicator(
                                value: percent,
                                minHeight: 8,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getProgressColor(percent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final int currentStock;
  final int stockPerBasket;
  final int possibleBaskets;
  final int minStock;
  final String unit;
  final String status;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.currentStock,
    required this.stockPerBasket,
    required this.possibleBaskets,
    required this.minStock,
    required this.unit,
    required this.status,
  });
}

class StatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color accentColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconBg = accentColor.withOpacity(0.15);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accentColor, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProductInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
