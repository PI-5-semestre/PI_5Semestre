import 'package:core/widgets/modal/modal_agenda.dart';
import 'package:core/widgets/modal/modal_completa.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitsCard extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String observations;
  final String status; // realizada | pendente | cancelada | agendada

  const VisitsCard({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.observations,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case "realizada":
        return Color(0xFF016630);
      case "pendente":
        return Colors.orange;
      case "cancelada":
        return Colors.red;
      case "agendada":
        return Color(0xFF6E11B0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome + chips de status
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // ocupa o máximo disponível
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
                  children: [_buildChip(status, _getStatusColor(status))],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Linha com telefone
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
              ],
            ),
            const SizedBox(height: 8),

            // Endereço
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text(address)),
              ],
            ),
            const SizedBox(height: 8),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (status == "pendente")
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AgendarVisitaModal(
                          nome: "João Carlos Santos",
                          endereco:
                              "Av. Central, 456 - Centro, São Paulo - SP, CEP: 01234-000",
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Agendar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),

                if (status == "agendada")
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CompletarVisitaModal(
                          nome: "João Carlos Santos",
                          endereco:
                              "Av. Central, 456 - Centro, São Paulo - SP, CEP: 01234-000",
                        ),
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.circleCheck),
                    label: const Text("Completar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
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
