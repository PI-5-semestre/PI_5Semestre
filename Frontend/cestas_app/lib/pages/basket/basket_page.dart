import 'package:cestas_app/pages/family/new_family_page.dart';
import 'package:flutter/material.dart';
import 'package:cestas_app/widgets/app_drawer.dart';
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
                    _buildButton(context),
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
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (ctx) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Famílias Selecionadas",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ...selectedFamilies.entries
                                      .where((e) => e.value)
                                      .map(
                                        (e) => ListTile(
                                          leading: const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                          title: Text(e.key),
                                        ),
                                      ),
                                  const SizedBox(height: 8),
                                ],
                              ),
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
        address: "Rua Exemplo, 123 - Bairro Exemplo, São Paulo - SP",
        observations: "Família em situação de vulnerabilidade.",
        status: "ativa",
        deliveryStatus: "aguardando",
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

  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const NewFamilyPage()));
      },
      icon: const Icon(Icons.settings, color: Colors.white),
      label: const Text(
        'Configurar Cesta',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF155DFC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
