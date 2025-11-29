import 'package:core/core.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/features/visits/providers/visit_provider.dart';
import 'package:core/widgets/visit_card.dart';
import 'package:core/widgets2/skeleton/stat_card_skeleton.dart';
import 'package:core/widgets2/skeleton/team_card_skeleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitsPage extends ConsumerStatefulWidget {
  const VisitsPage({super.key});

  @override
  ConsumerState<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends ConsumerState<VisitsPage>  {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(visitControllerProvider);
      if (state.visities.isEmpty && !state.isLoading) {
        ref.read(visitControllerProvider.notifier).fetchVisits();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visitState = ref.watch(visitControllerProvider);
    final controller = ref.watch(visitControllerProvider.notifier);

    if (!visitState.isLoading &&
      visitState.error != null &&
      visitState.visities.isEmpty) {
        return Center(child: Text("Não foi possível carregar as visitas"));
      }

    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Total de Visititas",
        value: visitState.visities.length.toString(),
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Aprovadas",
        value: visitState.visities.where((v) => v.response?.roleStatus == "Aprovada").length.toString(),
      ),
      StatCard(
        icon: Icons.event,
        colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
        title: "Agendadas",
        value: visitState.visities.where((v) => v.response == null || v.response?.roleStatus == "Agendada").length.toString(),
      ),
      StatCard(
        icon: Icons.close,
        colors: [Color(0xFFC90000), Color(0xFFA60000)],
        title: "Reprovadas",
        value: visitState.visities.where((v) => v.response?.roleStatus == "Reprovada").length.toString(),
      ),
    ];

    final iconCards = [
      Icons.groups,
      Icons.check,
      Icons.event,
      Icons.close,
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchVisits();
        },
        child: Padding(
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
                      _buildTodayLabel(context, theme), 
                      const SizedBox(height: 16),
                      _buildSearchField(ref),
                      const SizedBox(height: 5),
                      if (visitState.isLoading)
                        Row(
                          children: const [
                            Expanded(child: StatCardSkeleton()),
                          ],
                        )
                      else
                        SegmentedCardSwitcher(
                          options: cards, 
                          icons: iconCards,
                          onTap: (index){
                            switch (index) {
                              case 0:
                                controller.filterByRole(null);
                                break;
                              case 1:
                                controller.filterByRole('ACCEPTED');
                                break;
                              case 2:
                                controller.filterByRole('PENDING');
                                break;
                              case 3:
                                controller.filterByRole('REJECTED');
                                break;
                            } 
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildfamilyHeader(theme),
                  if (visitState.isLoading)
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
                    Column(
                      children: visitState.filtered.map((visit) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: VisitCard(visit: visit),
                        );
                      }).toList(),
                    )
                ],
              ),
            ],
          ),
        ),
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
      title: 'Gestão de Visitas',
      subtitle: 'Agendamento e validação de visitas ',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.group,
    );
  }

    Widget _buildTodayLabel(BuildContext context, ThemeData theme) {
    final now = DateTime.now().toUtc().subtract(const Duration(hours: 3));
    final formattedDate = DateFormat("EEEE | dd/MM/yyyy", "pt_BR").format(now);
    final capitalizedDate = formattedDate[0].toUpperCase() + formattedDate.substring(1);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone dentro do círculo
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today,
                color: theme.colorScheme.primary,
                size: 25,
              ),
            ),
            const SizedBox(height: 16),

            // Texto principal
            const Text(
              "Visitas de Hoje",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Data
            Text(
              capitalizedDate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F6F6F),
              ),
            ),
          ],
        ),
      ),
    );
  }  

}
