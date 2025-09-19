import 'package:flutter/material.dart';
import 'package:core/widgets/family_card.dart';

class FamilyList extends StatelessWidget {
  final bool isSelectedMaria;
  final bool isSelectedAna;
  final bool isSelectedJoao;
  final Function(bool?) onChangedMaria;
  final Function(bool?) onChangedAna;
  final Function(bool?) onChangeJoao;

  const FamilyList({
    required this.isSelectedMaria,
    required this.isSelectedAna,
    required this.isSelectedJoao,
    required this.onChangedMaria,
    required this.onChangedAna,
    required this.onChangeJoao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Familias aguardando cesta',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Gerar Cesta'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FamilyCard(
              name: 'Maria da Silva Santos',
              phone: '(xx)xxxxx-xxxx',
              members: 5,
              income: 1222.22,
              cpf: '323454321-09',
              address: 'Rua das Flores, 123',
              observations: 'observations',
              status: 'status',
              deliveryStatus: 'deliveryStatus',
            ),
            FamilyCard(
              name: 'Ana Paula  Oliveira',
              phone: '(xx)xxxxx-xxxx',
              members: 5,
              income: 1222.22,
              cpf: '323454321-09',
              address: 'Rua das Flores, 123',
              observations: 'observations',
              status: 'status',
              deliveryStatus: 'deliveryStatus',
            ),
            FamilyCard(
              name: 'João Pedro Fereira',
              phone: '(xx)xxxxx-xxxx',
              members: 5,
              income: 1222.22,
              cpf: '323454321-09',
              address: 'Rua das Flores, 123',
              observations: 'observations',
              status: 'status',
              deliveryStatus: 'deliveryStatus',
            ),
          ],
        ),
      ),
    );
  }
}
