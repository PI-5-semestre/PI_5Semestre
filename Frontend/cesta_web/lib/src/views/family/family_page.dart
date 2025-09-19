import 'package:cesta_web/src/views/family/new_family_page.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/family_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 600 ? 8.0 : 16.0; // menos espaço no mobile
    bool isWeb =
        MediaQuery.of(context).size.width > 600; // menos espaço no mobile

    final cards = [
      StatCard(
        icon: Icons.group,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Famílias Ativas",
        value: "2",
      ),
      StatCard(
        icon: Icons.event,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Aguardando Visita",
        value: "1",
      ),
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Total Cadastradas",
        value: "3",
      ),
    ];

    final families = [
      FamilyCard(
        name: "Maria da Silva Santos",
        phone: "(11) 99999-0001",
        members: 4,
        income: 800,
        cpf: "123.456.789-00",
        address: "Rua das Flores, 123, Apto 45 - Vila Nova, São Paulo - SP",
        observations:
            "Família com 2 crianças pequenas, muito necessitada. Mãe desempregada.",
        status: "ativa",
        deliveryStatus: "recebendo",
      ),
      FamilyCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        members: 3,
        income: 600,
        cpf: "987.654.321-00",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "pendente",
        deliveryStatus: "aguardando",
      ),
      FamilyCard(
        name: "Maria da Silva Santos",
        phone: "(11) 99999-0001",
        members: 4,
        income: 800,
        cpf: "123.456.789-00",
        address: "Rua das Flores, 123, Apto 45 - Vila Nova, São Paulo - SP",
        observations:
            "Família com 2 crianças pequenas, muito necessitada. Mãe desempregada.",
        status: "ativa",
        deliveryStatus: "recebendo",
      ),
      FamilyCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        members: 3,
        income: 600,
        cpf: "987.654.321-00",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "pendente",
        deliveryStatus: "aguardando",
      ),
      FamilyCard(
        name: "Maria da Silva Santos",
        phone: "(11) 99999-0001",
        members: 4,
        income: 800,
        cpf: "123.456.789-00",
        address: "Rua das Flores, 123, Apto 45 - Vila Nova, São Paulo - SP",
        observations:
            "Família com 2 crianças pequenas, muito necessitada. Mãe desempregada.",
        status: "ativa",
        deliveryStatus: "recebendo",
      ),
      FamilyCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        members: 3,
        income: 600,
        cpf: "987.654.321-00",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "pendente",
        deliveryStatus: "aguardando",
      ),
    ];

    return Scaffold(
      // appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Center(
        child: SizedBox(
          width: 1300,
          child: Padding(
            padding: screenWidth > 800
                ? const EdgeInsets.only(left: 16, right: 16, top: 16)
                : EdgeInsets.only(left: 16, right: 16), // ou outro padding para telas menores
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildCardHeader()),
                        const SizedBox(width: 16),
                        _buildButton(context),
                      ],
                    ),

                    SizedBox(height: spacing),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: cards,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacing),

                    // Search
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Buscar família...",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: spacing),

                    // Lista de famílias
                    Column(
                      children: families.map((family) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ), // horizontal agora
                          child: SizedBox(
                            width: double.infinity,
                            child: family,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Famílias Cadastradas',
      subtitle: 'Gerencie as famílias beneficiárias',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.group,
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const NewFamilyPage()));
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Nova Família', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF155DFC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
