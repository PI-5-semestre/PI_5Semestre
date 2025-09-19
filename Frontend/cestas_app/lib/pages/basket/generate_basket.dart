import 'package:flutter/material.dart';

class GenerateBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Cestas Geradas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.print),
                  label: const Text('Imprimir Checklist'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ExpansionTile(
              title: Row(
                children: const [
                  Text("Maria da Silva Santos"),
                  SizedBox(width: 8),
                  Chip(label: Text('Média')),
                ],
              ),
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('OK')),
                    DataColumn(label: Text('Item')),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.check_box)),
                        DataCell(Text('Arroz 5Kg')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.check_box)),
                        DataCell(Text('Feijão 1Kg')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Icon(Icons.check_box)),
                        DataCell(Text('Óleo 900ml')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
