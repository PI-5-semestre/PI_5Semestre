import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.icon,
    required this.colors,
    required this.title,
    required this.subtitle,
    this.iconSize = 24.0,
    this.titleStyle,
    this.subtitleStyle,
  });

  final IconData icon;
  final List<Color> colors;
  final String title;
  final String subtitle;
  final double iconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
              icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Textos com quebra de linha
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: titleStyle ?? TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: subtitleStyle ?? TextStyle(
                    fontSize: 14, 
                    color: Colors.grey,
                  ),
                  softWrap: true, // Permite quebra de linha
                  overflow: TextOverflow.visible, // Mostra todo o texto
                  maxLines: 3, // Limite máximo de linhas (opcional)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}