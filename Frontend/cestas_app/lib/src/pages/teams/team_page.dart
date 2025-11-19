import 'package:core/features/user/providers/user_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/skeleton/stat_card_skeleton.dart';
import 'package:core/widgets2/team_card.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:core/widgets2/skeleton/team_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final userState = ref.watch(userControllerProvider);
    final controller = ref.read(userControllerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState.users.isEmpty && !userState.isLoading) {
        controller.fetchUsers();
      }
    });

    if (userState.error != null && userState.users.isEmpty) {
      return Center(child: Text("Não foi possível carregar os usuários"));
    }

    final cards = [
      StatCard(
        icon: Icons.group,
        colors: [Color(0xFFFF4646), Color(0xFFFA6210)],
        title: "Todos",
        value: userState.users.length.toString(),
      ),
      StatCard(
        icon: Icons.key,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Coordenadores",
        value: userState.users.where((u) => u.roleName == "Coordenador").length.toString(),
      ),
      StatCard(
        icon: Icons.sports_motorsports,
        colors: [Color(0xFF3d89ff), Color(0xFF165ffc)],
        title: "Entregadores",
        value: userState.users.where((u) => u.roleName == "Entregador").length.toString(),
      ),
      StatCard(
        icon: Icons.content_paste,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Assistentes Sociais",
        value: userState.users.where((u) => u.roleName == "Assistente Social").length.toString(),
      ),
      StatCard(
        icon: Icons.soup_kitchen,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Voluntários",
        value: userState.users.where((u) => u.roleName == "Voluntário").length.toString(),
      ),
    ];

    final iconCards = [
      Icons.group,
      Icons.key,
      Icons.sports_motorsports,
      Icons.content_paste,
      Icons.soup_kitchen,
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Column(
              children: [
                _buildCardHeader(),
                const SizedBox(height: 16),
                _buildSearchField(ref),
                const SizedBox(height: 8),
                if (userState.isLoading)
                  Row(
                    children: const [
                      Expanded(child: StatCardSkeleton()),
                    ],
                  )
                else
                  SegmentedCardSwitcher(
                    options: cards,
                    icons: iconCards,
                    onTap: (index) {
                      final controller = ref.read(userControllerProvider.notifier);

                      switch (index) {
                        case 0:
                          controller.filterByRole(null);
                          break;
                        case 1:
                          controller.filterByRole("Coordenador");
                          break;
                        case 2:
                          controller.filterByRole("Entregador");
                          break;
                        case 3:
                          controller.filterByRole("Assistente Social");
                          break;
                        case 4:
                          controller.filterByRole("Voluntário");
                          break;
                      }
                    },
                  ),
                const SizedBox(height: 20),
                _buildEquipesHeader(theme),

                if (userState.isLoading && userState.users.isEmpty)
                  Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: const TeamCardSkeleton(),
                      ),
                    ),
                  )
                else
                  // Lista real
                  Column(
                    children: userState.filtered.map((account) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: TeamCardModal(account: account),
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
          context.go('/more/team/new_servant');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (v) => ref.read(userControllerProvider.notifier).search(v),
          decoration: const InputDecoration(
            hintText: "Nome, e-mail, celular ou CPF...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEquipesHeader(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
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
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Funcionários Cadastrados',
      subtitle: 'Gerencie sua equipe',
      colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.group,
    );
  }
}
