import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets/visits_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 600 ? 8.0 : 16.0; // menos espaço no mobile

    final cards = [
      StatCard(
        icon: FontAwesomeIcons.clock,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Pendentes",
        value: "2"
      ),
      StatCard(
        icon: FontAwesomeIcons.calendar,
        colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
        title: "Agendadas",
        value: "0"
      ),
      StatCard(
        icon: FontAwesomeIcons.circleCheck,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Realizadas",
        value: "0"
      ),
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
      body: ScreenSizeWidget(
        child: Column(
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
              
            LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                double spacing = 16;
              
                // Define o número máximo de colunas baseado na largura da tela
                int maxColumns = maxWidth > 1300
                    ? 5
                    : maxWidth > 1200
                    ? 4
                    : maxWidth > 800
                    ? 3
                    : maxWidth > 500
                    ? 2
                    : 1;
              
                // Número de colunas não pode ser maior que a quantidade de cards
                int columns = cards.length < maxColumns
                    ? cards.length
                    : maxColumns;
              
                double totalSpacing = spacing * (columns - 1);
                double cardWidth = (maxWidth - totalSpacing) / columns;
              
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: cards
                      .map(
                        (card) =>
                            SizedBox(width: cardWidth, child: card),
                      )
                      .toList(),
                );
              },
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
