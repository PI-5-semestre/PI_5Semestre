import 'package:cestas_app/widgets/app_drawer.dart';
import 'package:cestas_app/widgets/statCard.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Grid de cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3.5,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
