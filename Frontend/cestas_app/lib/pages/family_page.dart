
import 'package:cestas_app/widgets/app_drawer.dart';
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

    int crossAxisCount = 1;
    if (screenWidth > 1200) {
      crossAxisCount = 3; // web grande
    } else if (screenWidth > 800) {
      crossAxisCount = 2; // tablet
    }

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
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isMobile = constraints.maxWidth < 600;

                    return isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildCardHeader(),
                              const SizedBox(height: 16),
                              _buildButton(),
                            ],
                          )
                        : Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: _buildCardHeader()),
                                const SizedBox(width: 16),
                                _buildButton(),
                              ],
                            ),
                          );
                  },
                ),

                SizedBox(height: spacing),

                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment
                      .spaceBetween, // controla o alinhamento das linhas
                  spacing: 8.0, // espaço horizontal entre os itens
                  runSpacing: 8.0, // espaço vertical entre as linhas
                  children: cards,
                ),

                // Wrap(children: List.generate(30, (index) => Text('${index + 1}'),),),
                SizedBox(height: spacing),

                // Search
                Card(
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
                Column(children: families),
              ],
            ),
          ],
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

  Widget _buildButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Nova Família', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF155DFC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
