import 'package:cesta_web/src/views/family/new_family_page.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/widgets/card_info.dart';
import 'package:core/widgets/modal/product_card.dart';
import 'package:core/widgets/filter-search.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 600 ? 8.0 : 16.0;

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
        value: "8",
      ),
      StatCard(
        icon: Icons.warning_amber_rounded,
        colors: [Color(0xFFecab00), Color(0xFFd69417)],
        title: "Estoque Baixo",
        value: "1",
      ),
      StatCard(
        icon: Icons.error,
        colors: [Color(0xFFf82632), Color(0xFFe90012)],
        title: "Sem Estoque",
        value: "0",
      ),
    ];

    final products = [
      ProductCard(
        name: "Arroz Branco",
        category: "Grãos",
        currentStock: 150,
        stockPerBasket: 2,
        possibleBaskets: 75,
        minStock: 30,
        unit: "kg",
        status: "in-stock",
      ),
      ProductCard(
        name: "Feijão Carioca",
        category: "Grãos",
        currentStock: 120,
        stockPerBasket: 1,
        possibleBaskets: 120,
        minStock: 25,
        unit: "kg",
        status: "in-stock",
      ),
      ProductCard(
        name: "Óleo de Soja",
        category: "Óleos",
        currentStock: 80,
        stockPerBasket: 1,
        possibleBaskets: 80,
        minStock: 15,
        unit: "l",
        status: "in-stock",
      ),
      ProductCard(
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

    final infoCard = [
      InfoCard(
        title: "Estoque Baixo",
        color: Colors.red,
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.white,
        iconBackground: Colors.red[700],
        child: Column(
          children: [
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Arroz 5kg"),
              subtitle: Text("Mínimo: 10 unidades"),
              trailing: _badge("2 unidades"),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Feijão 1kg"),
              subtitle: Text("Mínimo: 15 unidades"),
              trailing: _badge("4 unidades"),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Óleo de Soja"),
              subtitle: Text("Mínimo: 8 unidades"),
              trailing: _badge("3 unidades"),
            ),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCardHeader(),
                  const SizedBox(height: 16),
                  _buildButton(context),
                ],
              ),

              SizedBox(height: spacing),

              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                spacing: 8.0,
                runSpacing: 8.0,
                children: cards,
              ),

              SizedBox(height: spacing),

              Column(
                children: infoCard
                    .map(
                      (card) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: card,
                      ),
                    )
                    .toList(),
              ),

              SizedBox(height: spacing),

              Column(
                children: [
                  FilterSearch(
                    categories: ["Bebida", "Grãos", "Café"],
                    onChanged: (search, category) {
                      print("Filtro: $search / $category");
                    },
                  ),
                ],
              ),

              SizedBox(height: spacing),

              // Lista de produtos
              Column(
                children: products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    child: SizedBox(width: double.infinity, child: product),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Cabeçalho
  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Controle de Estoque',
      subtitle: 'Gerencie os produtos das cestas básicas',
      colors: [Color(0xFF00c64f), Color(0xFF00a73e)],
      icon: Icons.archive_outlined,
    );
  }

  /// Botão de Novo Produto
  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const NewFamilyPage()));
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Novo Produto', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00c64f),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Badge usado no InfoCard
  static Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
