import 'package:core/core.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/widgets2/skeleton/stat_card_skeleton.dart';
import 'package:core/widgets2/skeleton/team_card_skeleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FamilyPage extends ConsumerStatefulWidget {
  const FamilyPage({super.key});

  @override
  ConsumerState<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends ConsumerState<FamilyPage>  {
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
    final controller = ref.watch(familyControllerProvider.notifier);
    final theme = Theme.of(context);

    if (!familyState.isLoading &&
        familyState.error != null &&
        familyState.families.isEmpty) {
      return Center(child: Text("Não foi possível carregar as famílias"));
    }

    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Total Cadastradas",
        value: familyState.families.length.toString(),
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Famílias Ativas",
        value: familyState.families.where((f) => f.roleSituation == "Ativa").length.toString(),
      ),
      StatCard(
        icon: Icons.event,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Aguardando Visita",
        value: familyState.families.where((f) => f.roleSituation == "Pendente").length.toString(),
      ),
    ];

    final iconCards = [Icons.groups, Icons.check, Icons.event];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCardHeader(), 
                    const SizedBox(height: 16),
                    _buildSearchField(ref),
                    if (familyState.isLoading)
                      Row(
                        children: const [
                          Expanded(child: StatCardSkeleton())
                        ],
                      )
                    else
                      SegmentedCardSwitcher(
                        options: cards, 
                        icons: iconCards,
                        onTap: (index) {
                          switch (index) {
                            case 0:
                              controller.filterByRole(null);
                            case 1:
                              controller.filterByRole("ACTIVE");
                            case 2:
                              controller.filterByRole("PENDING");
                            default:
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildfamilyHeader(theme),
                if (familyState.isLoading && familyState.families.isEmpty)
                  const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Center(child: TeamCardSkeleton()),
                  )
                else
                Column(
                  children: familyState.filtered.map((family) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: FamilyCard(family: family),
                    );
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/family/new_family');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (v) => ref.read(familyControllerProvider.notifier).search(v),
          decoration: const InputDecoration(
            hintText: "Nome, CPF, CEP ou Endereço...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildfamilyHeader(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Famílias",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.outline,
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
}
