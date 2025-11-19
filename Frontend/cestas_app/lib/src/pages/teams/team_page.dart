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
import 'package:intl/intl.dart';

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

    if (userState.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Erro: ${userState.error!}",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final cards = [
      StatCard(
        icon: Icons.person,
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
      Icons.person,
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
                _buildSearchField(),
                const SizedBox(height: 8),
                if (userState.isLoading)
                  Row(
                    children: const [
                      Expanded(child: StatCardSkeleton()),
                    ],
                  )
                else
                  SegmentedCardSwitcher(options: cards, icons: iconCards),
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
                    children: userState.users.map((account) {
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

  Widget _buildSearchField() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Nome, celular ou cpf...",
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
