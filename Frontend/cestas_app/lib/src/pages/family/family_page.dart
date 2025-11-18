import 'package:core/features/family/providers/family_view_model.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/family_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FamilyPage extends ConsumerWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familiesVm = ref.watch(familyViewModelProvider);
    final theme = Theme.of(context);

    final total = familiesVm.maybeWhen(
      data: (families) => families.length,
      orElse: () => 0,
    );

    final ativas = familiesVm.maybeWhen(
      data: (families) => families.where((f) => f.active == true).length,
      orElse: () => 0,
    );

    final cards = [
      StatCard(
        icon: Icons.groups,
        colors: [Color(0xFFAD46FF), Color(0xFF9810FA)],
        title: "Total Cadastradas",
        value: total.toString(),
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Famílias Ativas",
        value: ativas.toString(),
      ),
      StatCard(
        icon: Icons.event,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Aguardando Visita",
        value: total.toString(),
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
                  children: [_buildCardHeader(), const SizedBox(height: 16)],
                ),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Nome, celular ou cpf...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SegmentedCardSwitcher(options: cards, icons: iconCards),
                SizedBox(height: 20),
                Align(
                  alignment: AlignmentGeometry.topLeft,
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
                ),

                familiesVm.when(
                  loading: () => Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      err.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  data: (families) => Column(
                    children: families.map((family) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        child: FamilyCardModal(
                          name: family.name,
                          phone: family.mobile_phone ?? "",
                          members: 1,
                          income: family.income,
                          cpf: family.cpf,
                          address: family.street,
                          observations: family.description,
                          status: (family.active ?? false)
                              ? "Ativo"
                              : "Pendente",
                          deliveryStatus: "Aguardando",
                          recommended: "",
                        ),
                      );
                    }).toList(),
                  ),
                ),
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

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Famílias Cadastradas',
      subtitle: 'Gerencie as famílias beneficiárias',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.group,
    );
  }
}
