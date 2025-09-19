import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCard extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String deliveryStatus; // "Pendente" | "Entregue" | "Não Entregue"
  final String observations;

  const DeliveryCard({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.deliveryStatus,
    this.observations = "",
  });

  // retorna cor do texto e cor de fundo para o chip
  Color _getTextColor(String status) {
    switch (status.toLowerCase()) {
      case "entregue":
        return Colors.green.shade800;
      case "não entregue":
        return Colors.red.shade800;
      default:
        return Colors.orange.shade800;
    }
  }

  Color _getBgColor(String status) {
    switch (status.toLowerCase()) {
      case "entregue":
        return const Color.fromARGB(50, 144, 254, 148);
      case "não entregue":
        return const Color.fromARGB(50, 236, 143, 137);
      default:
        return const Color.fromARGB(50, 244, 244, 178);
    }
  }

  Widget _buildChip(String text) {
    final textColor = _getTextColor(text);
    final bgColor = _getBgColor(text);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  void _openInGoogleMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Não foi possível abrir o Google Maps: $e");
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
            // Nome + chip + botão mapa
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildChip(deliveryStatus),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () => _openInGoogleMaps(address),
                  tooltip: "Abrir no Google Maps",
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 4),
                Text(phone),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text(address)),
              ],
            ),
            const SizedBox(height: 8),

            if (observations.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(17, 171, 171, 171),
                  borderRadius: BorderRadius.circular(6),
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
          ],
        ),
      ),
    );
  }
}
