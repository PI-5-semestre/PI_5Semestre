import 'package:cestas_app/src/widgets/app_drawer.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets/visits_card.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Total de Visititas",
        value: "3",
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Realizadas",
        value: "0",
      ),
      StatCard(
        icon: Icons.schedule,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Pendentes",
        value: "2",
      ),
      StatCard(
        icon: Icons.event,
        colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
        title: "Agendadas",
        value: "0",
      ),
      StatCard(
        icon: Icons.close,
        colors: [Color(0xFFC90000), Color(0xFFA60000)],
        title: "Canceladas",
        value: "0",
      ),
    ];

    final iconCards = [
      Icons.groups,
      Icons.check,
      Icons.schedule,
      Icons.event,
      Icons.close,
    ];

    final families = [
      VisitsCard(
        name: "Maria da Silva Santos",
        phone: "(11) 99999-0001",
        address: "Rua das Flores, 123, Apto 45 - Vila Nova, São Paulo - SP",
        observations:
            "Família com 2 crianças pequenas, muito necessitada. Mãe desempregada.",
        status: "realizada",
      ),
      VisitsCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "pendente",
      ),
      VisitsCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "agendada",
      ),
      VisitsCard(
        name: "João Carlos Santos",
        phone: "(11) 99999-0002",
        address: "Av. Central, 456 - Centro, São Paulo - SP",
        observations:
            "Aguardando primeira visita de avaliação. Situação de desemprego recente.",
        status: "cancelada",
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
                      "Famílias",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Lista de famílias
                Column(
                  children: families.map((family) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ), // horizontal agora
                      child: SizedBox(width: double.infinity, child: family),
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
      title: 'Gestão de Visitas',
      subtitle: 'Agende e gerencie as visitas às famílias cadastradas',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: FontAwesomeIcons.calendar,
    );
  }
}
