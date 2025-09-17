import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.icon,
    required this.colors,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final List<Color> colors;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        children: [
          // Ícone e textos
          Expanded(
            child: Row(
              children: [
                // Ícone
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon, // ou qualquer outro ícone
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                // Título e subtítulo
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ), // Botão "Nova Família"
        ],
      ),
    );
  }
}
