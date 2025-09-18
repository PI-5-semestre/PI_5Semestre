import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/widgets/card_info.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var message =
        "Bem-vindo ao sistema de gestão de cestas básicas da nossa comunidade. Aqui você\npode acompanhar todas as atividades e ajudar quem mais precisa.";

    final startMessage = [
      Container(
        margin: const EdgeInsets.only(bottom: 32, top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.heart,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Painel de Controle',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ];

    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
        title: "Famílias Cadastradas",
        value: "156",
      ),
      StatCard(
        icon: Icons.shopping_cart,
        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
        title: "Cestas Disponíveis",
        value: "24",
      ),
      StatCard(
        icon: Icons.local_shipping,
        colors: [Color(0xFFFF9800), Color(0xFFEF6C00)],
        title: "Visitas Pendentes",
        value: "8",
      ),
      StatCard(
        icon: Icons.inventory,
        colors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
        title: "Produtos em estoque",
        value: "342",
      ),
    ];

    final infoCard = [
      InfoCard(
        title: "Atividades Recentes",
        color: Colors.blueAccent,
        icon: Icons.timeline,
        iconColor: Colors.white,
        iconBackground: Colors.blue[700],
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.family_restroom, color: Colors.blue),
              title: Text("Nova família cadastrada"),
              subtitle: Text("Maria Silva"),
              trailing: Text("2h atrás"),
            ),
            Divider(),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.truck,
                color: Colors.green,
              ),
              title: Text("Cesta entregue"),
              subtitle: Text("João Santos"),
              trailing: Text("4h atrás"),
            ),
            Divider(),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.cartPlus,
                color: Colors.orange,
              ),
              title: Text("Produto adicionado"),
              subtitle: Text("Arroz - 5kg"),
              trailing: Text("6h atrás"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.house, color: Colors.blue),
              title: Text("Visita agendada"),
              subtitle: Text("Ana Costa"),
              trailing: Text("1d atrás"),
            ),
          ],
        ),
      ),
      InfoCard(
        title: "Estoque Baixo",
        color: Colors.orange,
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.white,
        iconBackground: Colors.orangeAccent[700],
        child: Column(
          children: [
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Arroz 5kg"),
              subtitle: Text("Mínimo: 10 unidades"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  "2 unidades",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Feijão 1kg"),
              subtitle: Text("Mínimo: 15 unidades"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  "4 unidades",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.boxOpen, color: Colors.red),
              title: Text("Óleo de Soja"),
              subtitle: Text("Mínimo: 8 unidades"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  "3 unidades",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Padding(
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3.5,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
              ),

              const SizedBox(height: 16),

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
            ],
          ),
        ),
      ),
    );
  }
}
