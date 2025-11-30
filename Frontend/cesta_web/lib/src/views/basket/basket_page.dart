import 'package:cesta_web/src/views/basket/basket_list_page.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets/family_card.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/widgets/basket_selected_families_modal.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final Map<String, bool> selectedFamilies = {
    "Maria da Silva Santos": false,
    "Ana Oliveira": false,
    "João Carlos Santos": false,
  };

  final Map<String, double> familyIncome = {
    "Maria da Silva Santos": 700.00,
    "Ana Oliveira": 1200.00,
    "João Carlos Santos": 950.00,
  };

  final List<String> basketSizes = ['Pequena', 'Média', 'Grande'];
  final Map<String, String> basketSizeByFamily = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 600 ? 8.0 : 16.0;
    final selectedCount = selectedFamilies.values.where((v) => v).length;

    final cards = [
      StatCard(
        icon: Icons.group,
        colors: [Colors.green, Colors.green],
        title: "Famílias Selecionadas",
        value: selectedCount.toString(),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (ctx) {
              return StatefulBuilder(
                builder: (ctx, setModalState) {
                  final selected = selectedFamilies.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .toList();

                  for (var name in selected) {
                    basketSizeByFamily.putIfAbsent(name, () => 'Média');
                  }

                  return BasketSelectedFamiliesModal(
                    selectedFamilies: selected,
                    familyIncome: familyIncome,
                    basketSizeByFamily: basketSizeByFamily,
                    basketSizes: basketSizes,
                    onSizeChanged: (familyName, newSize) {
                      setModalState(() {
                        basketSizeByFamily[familyName] = newSize;
                      });
                    },
                    onSave: () {
                      if (selected.isEmpty) return;

                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Cestas salvas para ${selected.length} família(s).',
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    buildEditButton: (context, familyName) =>
                        _buildButton(context, familyName),
                  );
                },
              );
            },
          );
        },
      ),
      StatCard(
        icon: Icons.shopping_basket,
        colors: [Colors.orangeAccent, Colors.orangeAccent],
        title: "Cestas Disponíveis",
        value: "10",
      ),
    ];

    final icons = [Icons.group, Icons.shopping_basket];

    return Scaffold(
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_buildCardHeader(), const SizedBox(height: 16)],
                ),
                SizedBox(height: spacing),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Buscar família...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                SegmentedCardSwitcher(options: cards, icons: icons),

                SizedBox(height: spacing),
                ...selectedFamilies.entries.map((entry) {
                  return Column(
                    children: [
                      // FamilyCard(
                      //   name: entry.key,
                      //   phone: "(19) 99999-0000",
                      //   members: 4,
                      //   income: 700,
                      //   cpf: "000.000.000-00",
                      //   address:
                      //       "Rua Exemplo, 123 - Bairro Exemplo, São Paulo - SP",
                      //   observations: "Família em situação de vulnerabilidade.",
                      //   status: "ativa",
                      //   deliveryStatus: "aguardando",
                      //   recommended: "Recomendado Pequena",
                      //   selected: entry.value,
                      //   onSelected: (bool? v) {
                      //     setState(() {
                      //       selectedFamilies[entry.key] = v ?? false;
                      //     });
                      //   },
                      // ),
                      const SizedBox(height: 12),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Distribuição de Cestas',
      subtitle: 'Faça a distribuição para às famílias cadastradas',
      colors: const [Colors.orangeAccent, Colors.orangeAccent],
      icon: FontAwesomeIcons.basketShopping,
    );
  }

  Widget _buildButton(BuildContext context, String name) {
    return ElevatedButton.icon(
      onPressed: () {
        final itemControllers = <String, TextEditingController>{};

        void handleSave() {
          for (var entry in itemControllers.entries) {
            print('${entry.key}: ${entry.value.text}');
          }
          Navigator.of(context).pop();
        }

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FamilyBasketEditor(
              familyName: name,
              itemControllers: itemControllers,
              onSave: handleSave,
            ),
          ),
        );
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Editar Cesta', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF155DFC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
