import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/widgets/statCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var message =
        "Bem-vindo ao sistema de gestão de cestas básicas da nossa comunidade. Aqui você pode acompanhar todas as atividades e ajudar quem mais precisa.";

    return Scaffold(body: _buildDashboard(message));
  }

  Widget _buildDashboard(String message) {
    final startMessage = [
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.heart,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Painel de Controle',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ];

    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: const [Color(0xFF2196F3), Color(0xFF1565C0)],
        title: "Famílias Cadastradas",
        value: "156",
      ),
      StatCard(
        icon: Icons.shopping_basket,
        colors: const [Color(0xFF4CAF50), Color(0xFF2E7D32)],
        title: "Cestas Disponíveis",
        value: "24",
      ),
      StatCard(
        icon: Icons.local_shipping,
        colors: const [Color(0xFFFF9800), Color(0xFFEF6C00)],
        title: "Visitas Pendentes",
        value: "8",
      ),
      StatCard(
        icon: Icons.inventory,
        colors: const [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
        title: "Produtos em estoque",
        value: "342",
      ),
    ];
    final iconCards = [
      Icons.groups,
      Icons.shopping_basket,
      Icons.local_shipping,
      Icons.inventory,
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...startMessage.map(
              (msg) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(child: msg),
              ),
            ),
            SegmentedCardSwitcher(options: cards, icons: iconCards),
            // GridView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 1,
            //     mainAxisSpacing: 16,
            //     crossAxisSpacing: 16,
            //     childAspectRatio: 3.5,
            //   ),
            //   itemCount: cards.length,
            //   itemBuilder: (context, index) => cards[index],
            // ),
          ],
        ),
      ),
    );
  }
}
