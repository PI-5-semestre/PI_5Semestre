import 'package:cestas_app/src/pages/basket/basket_list_page.dart';
import 'package:flutter/material.dart';
import 'package:cestas_app/src/widgets/app_drawer.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets/family_card.dart';
import 'package:core/widgets/card_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      appBar: AppBar(),
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
                  children: [
                    _buildCardHeader(),
                    const SizedBox(height: 16),
                  ],
                ),
                SizedBox(height: spacing),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
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
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (ctx) {
                            return StatefulBuilder(
                              builder: (ctx, setModalState) {
                                final selected = selectedFamilies.entries
                                    .where((e) => e.value)
                                    .map((e) => e.key)
                                    .toList();
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom:
                                        MediaQuery.of(ctx).viewInsets.bottom +
                                        16,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(ctx).size.height * 0.8,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                "Famílias Selecionadas",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Expanded(
                                          child: selected.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                    "Nenhuma família selecionada.",
                                                  ),
                                                )
                                              : SingleChildScrollView(
                                                  child: Column(
                                                    children: selected.map((
                                                      name,
                                                    ) {
                                                      basketSizeByFamily
                                                          .putIfAbsent(
                                                            name,
                                                            () => 'Média',
                                                          );
                                                      final renda =
                                                          familyIncome[name] ??
                                                          0.0;
                                                      return Card(
                                                        elevation: 2,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              bottom: 12,
                                                            ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                12,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                name,
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                "Renda: R\$ ${renda.toStringAsFixed(2)}",
                                                                style: const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 12,
                                                              ),
                                                              const Text(
                                                                "Tamanho da cesta",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              DropdownButtonFormField<
                                                                String
                                                              >(
                                                                value:
                                                                    basketSizeByFamily[name],
                                                                isExpanded:
                                                                    true,
                                                                decoration: const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            10,
                                                                      ),
                                                                ),
                                                                items: basketSizes
                                                                    .map(
                                                                      (
                                                                        s,
                                                                      ) => DropdownMenuItem(
                                                                        value:
                                                                            s,
                                                                        child:
                                                                            Text(
                                                                              s,
                                                                            ),
                                                                      ),
                                                                    )
                                                                    .toList(),
                                                                onChanged: (v) {
                                                                  if (v == null)
                                                                    return;
                                                                  setModalState(
                                                                    () {
                                                                      basketSizeByFamily[name] =
                                                                          v;
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              _buildButton(context, name),
                                                              const SizedBox(height: 16),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                onPressed: selected.isEmpty
                                                    ? null
                                                    : () {
                                                        Navigator.pop(ctx);
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Cestas salvas para ${selected.length} família(s).',
                                                            ),
                                                          ),
                                                        );
                                                        setState(
                                                          () {},
                                                        ); 
                                                      },
                                                icon: const Icon(Icons.save),
                                                label: const Text(
                                                  "Salvar cestas",
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    StatCard(
                      icon: Icons.shopping_basket,
                      colors: [Colors.blueAccent, Colors.blueAccent],
                      title: "Cestas Disponíveis",
                      value: "10",
                    ),
                  ],
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
                ...selectedFamilies.entries.map((entry) {
                  return Column(
                    children: [
                      FamilyCard(
                        name: entry.key,
                        phone: "(19) 99999-0000",
                        members: 4,
                        income: 700,
                        cpf: "000.000.000-00",
                        address:
                            "Rua Exemplo, 123 - Bairro Exemplo, São Paulo - SP",
                        observations: "Família em situação de vulnerabilidade.",
                        status: "ativa",
                        deliveryStatus: "aguardando",
                        recommended: "Recomendado Pequena",
                        selected: entry.value,
                        onSelected: (bool? v) {
                          setState(() {
                            selectedFamilies[entry.key] = v ?? false;
                          });
                        },
                      ),
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
      colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: FontAwesomeIcons.calendar,
    );
  }

  Widget _buildButton(BuildContext context, String name){
  return ElevatedButton.icon(
    onPressed: () {
      final itemControllers = <String, TextEditingController>{};

      void handleSave() {
        // Lógica ao salvar
        for (var entry in itemControllers.entries) {
          print('${entry.key}: ${entry.value.text}');
        }

        // Voltar para a tela anterior
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

