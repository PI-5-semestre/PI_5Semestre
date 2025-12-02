import 'package:core/features/basket/providers/basket_provider.dart';
import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/widgets2/basket_card.dart';
import 'package:core/widgets2/skeleton/basket_card_skeleton.dart';
import 'package:core/widgets2/families_activities_card.dart';
import 'package:core/widgets2/skeleton/families_activities_card_skeleton.dart';
import 'package:go_router/go_router.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({super.key});

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  int selectedSegment = 0;
  final TextEditingController _searchController = TextEditingController();
  String searchTerm = "";

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        searchTerm = _searchController.text.toLowerCase();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final familyState = ref.read(familyControllerProvider);
      if (familyState.families.isEmpty && !familyState.isLoading) {
        ref.read(familyControllerProvider.notifier).fetchFamilies();
      }
      ref.read(basketControllerProvider.notifier).findAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);
    final basketState = ref.watch(basketControllerProvider);
    final theme = Theme.of(context);

    final familiesActives = familyState.families
        .where(
          (f) =>
              f.roleSituation == "Ativa" &&
              f.name.toLowerCase().contains(searchTerm),
        )
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
        title: "Cestas Criadas",
        value: basketState.baskets.length.toString(),
      ),
    ];

    final icons = [Icons.group, Icons.shopping_basket];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            _buildCardHeader(),
            const SizedBox(height: 16),

            _buildSearchField(),

            const SizedBox(height: 16),

            SegmentedCardSwitcher(
              options: cards,
              icons: icons,
              onTap: (index) => setState(() => selectedSegment = index),
            ),

            const SizedBox(height: 16),

            if (selectedSegment == 0) ...[
              // ---------------- FAMÍLIAS ----------------
              if (familyState.isLoading)
                Column(
                  children: List.generate(
                    6,
                    (_) => const FamiliesActivitiesCardSkeleton(),
                  ),
                )
              else
                ...familiesActives.map((family) {
                  final hasBasket = basketState.baskets.any(
                    (b) => b.familyId == family.id,
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FamiliesActivitiesCardModal(
                      hasBasket: hasBasket,
                      family: family,
                      onTap: () {
                        if (hasBasket) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: const Text(
                                "Esta família já possui uma cesta cadastrada.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                          return;
                        }

                        context.go('/more/basket/create_basket', extra: family);
                      },
                    ),
                  );
                }),
            ] else ...[
              // ---------------- CESTAS ----------------
              if (basketState.isLoading)
                Column(
                  children: List.generate(6, (_) => const BasketCardSkeleton()),
                )
              else if (basketState.baskets.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      "Nenhuma cesta encontrada.",
                      style: TextStyle(color: theme.colorScheme.outline),
                    ),
                  ),
                )
              else
                ...basketState.baskets.map((basket) {
                  final family = familyState.families.firstWhere(
                    (f) => f.id == basket.familyId,
                    orElse: () => FamilyModel(
                      id: 0,
                      name: "Família não encontrada",
                      cpf: '',
                      mobile_phone: '',
                      zip_code: '',
                      street: '',
                      number: '',
                      neighborhood: '',
                      state: '',
                      institution_id: 1,
                    ),
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: BasketCard(
                      basket: basket,
                      family: family, // ← passando a família
                    ),
                  );
                }),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Buscar família...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
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
