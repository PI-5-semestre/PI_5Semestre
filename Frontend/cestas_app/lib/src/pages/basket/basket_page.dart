import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:core/widgets2/families_activities_card.dart';
import 'package:core/widgets2/skeleton/families_activities_card_skeleton.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({super.key});

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  int selectedSegment = 0; // 0 = famílias, 1 = cestas por família

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(familyControllerProvider);
      if (state.families.isEmpty && !state.isLoading) {
        ref.read(familyControllerProvider.notifier).fetchFamilies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);
    final theme = Theme.of(context);

    final familiesActives = familyState.families
        .where((f) => f.roleSituation == "Ativa")
        .toList();

    final cards = [
      StatCard(
        icon: Icons.group,
        colors: const [Colors.green, Colors.green],
        title: "Famílias",
        value: familiesActives.length.toString(),
      ),
      StatCard(
        icon: Icons.shopping_basket,
        colors: const [Colors.orangeAccent, Colors.orangeAccent],
        title: "Cestas por Família",
        value: "10",
      ),
    ];

    final icons = [Icons.group, Icons.shopping_basket];

    return Scaffold(
      appBar: AppBar(title: const Text("Distribuição de Cestas")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            _buildCardHeader(),
            const SizedBox(height: 16),

            /// Campo de busca
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar família...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SegmentedCardSwitcher(options: cards, icons: icons),

            const SizedBox(height: 16),

            if (familyState.isLoading)
              Column(
                children: List.generate(
                  6,
                  (_) => const FamiliesActivitiesCardSkeleton(),
                ),
              )
            else
              _buildContent(familiesActives),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List families) {
    if (selectedSegment == 0) {
      return Column(
        children: families.map((family) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FamiliesActivitiesCardModal(family: family, onTap: () {}),
          );
        }).toList(),
      );
    }

    /// Mostrar Cestas por Família
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orange.shade50,
          ),
          child: const Center(
            child: Text(
              "Aqui você vai listar as cestas por família 👇",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardHeader() {
    return const CardHeader(
      title: 'Distribuição de Cestas',
      subtitle: 'Faça a distribuição para às famílias cadastradas',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: FontAwesomeIcons.basketShopping,
    );
  }
}
