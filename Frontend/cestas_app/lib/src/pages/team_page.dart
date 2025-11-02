import 'package:cestas_app/src/app.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/team_card.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cards = [
      StatCard(
        icon: Icons.person,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Coordenadores",
        value: "3",
      ),
      StatCard(
        icon: Icons.sports_motorsports,
        colors: [Color(0xFF3d89ff), Color(0xFF165ffc)],
        title: "Entregadores",
        value: "2",
      ),
      StatCard(
        icon: Icons.content_paste,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Assistentes Sociais",
        value: "1",
      ),
      StatCard(
        icon: Icons.soup_kitchen,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Voluntários",
        value: "1",
      ),
    ];

    final iconCards = [
      Icons.person,
      Icons.sports_motorsports,
      Icons.content_paste,
      Icons.soup_kitchen,
    ];

    final equipes = [
      TeamCardModal(
        name: "Maria da Silva Santos",
        phone: "(11) 99999-0001",
        cpf: "123.456.789-00",
        email: "maria@gmail.com",
        tipofunc: "Coordenadores",
        inicio: '31/05/2023',
      ),
      TeamCardModal(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        cpf: "987.654.321-00",
        email: "joao@gmail.com",
        tipofunc: "Voluntários",
        inicio: '20/06/2024',
      ),
      TeamCardModal(
        name: "Ana Oliveira",
        phone: "(11) 98888-0002",
        cpf: "555.666.777-88",
        email: "ana@gmail.com",
        tipofunc: "Assistentes Sociais",
        inicio: '20/06/2024',
      ),
      TeamCardModal(
        name: "Carlos Mendes",
        phone: "(11) 98888-0003",
        cpf: "999.888.777-66",
        email: "carlos@gmail.com",
        tipofunc: "Entregadores",
        inicio: '10/07/2025',
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
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
                SizedBox(height: 8),
                // Search
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Nome, celular ou cpf...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),

                SegmentedCardSwitcher(options: cards, icons: iconCards),

                SizedBox(height: 20),

                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Equipes",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ),

                // Lista de famílias
                Column(
                  children: equipes.map((team) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ), // horizontal agora
                      child: SizedBox(width: double.infinity, child: team),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/family/new_family');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Funcionários Cadastrados',
      subtitle: 'Gerencie sua equipe',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.group,
    );
  }
}
