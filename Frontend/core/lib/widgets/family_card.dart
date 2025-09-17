import 'package:flutter/material.dart';

class FamilyCard extends StatelessWidget {
  final String name;
  final String phone;
  final int members;
  final double income;
  final String cpf;
  final String address;
  final String observations;
  final String status; // ativo | pendente
  final String deliveryStatus; // recebendo | aguardando

  const FamilyCard({
    super.key,
    required this.name,
    required this.phone,
    required this.members,
    required this.income,
    required this.cpf,
    required this.address,
    required this.observations,
    required this.status,
    required this.deliveryStatus,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case "ativa":
        return Color(0xFF016630);
      case "pendente":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getDeliveryColor(String status) {
    switch (status) {
      case "recebendo":
        return Color(0xFF193CB8);
      case "aguardando":
        return Color(0xFF6E11B0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Nome + chips de status
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose, // não ocupa tudo, só o necessário
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: -6, // deixa mais compacto na vertical se quebrar
                  children: [
                    _buildChip(status, _getStatusColor(status)),
                    _buildChip(
                      deliveryStatus,
                      _getDeliveryColor(deliveryStatus),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Linha com telefone, membros, renda e cpf
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.phone, size: 16),
                    const SizedBox(width: 4),
                    Text(phone),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.group, size: 16),
                    const SizedBox(width: 4),
                    Text("$members pessoas"),
                  ],
                ),
                Text("Renda: R\$ ${income.toStringAsFixed(2)}"),
                Text("CPF: $cpf"),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Endereço
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text(address)),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Observações Color(0xFFFBF9FA),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(17, 171, 171, 171),
                borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(12),
              child: Text.rich(
                TextSpan(
                  text: "Observações: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: observations,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                if (status == "pendente")
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Solicitar Visita"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
