import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final String status; // "in-stock" | "low-stock" | "out-of-stock"
  final int currentStock;
  final int stockPerBasket;
  final int possibleBaskets;
  final int minStock;
  final String unit;
  final VoidCallback? onEdit;

  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.status,
    required this.currentStock,
    required this.stockPerBasket,
    required this.possibleBaskets,
    required this.minStock,
    required this.unit,
    this.onEdit,
  });

  double getStockPercentage() {
    final maxStock = minStock * 3;
    final v = currentStock / maxStock;
    return v.clamp(0.0, 1.0);
  }

  String getStatusLabel() => switch (status) {
        "in-stock" => "Em estoque",
        "low-stock" => "Estoque baixo",
        "out-of-stock" => "Sem estoque",
        _ => "Status",
      };

  Color getStatusColor() => switch (status) {
        "in-stock" => Colors.green,
        "low-stock" => Colors.orange,
        "out-of-stock" => Colors.red,
        _ => Colors.grey,
      };

  Color _progressColor(double p) {
    if (p >= 0.6) return Colors.green;
    if (p >= 0.3) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final percent = getStockPercentage();

    return Card(
      color: const Color(0xFFF6F6FA),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // tudo parte da esquerda
          mainAxisSize: MainAxisSize.min,
          children: [
            // CABEÇALHO — mesma linha
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _Pill(
                        text: category,
                        bg: Colors.black12.withOpacity(0.06),
                        fg: Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      _Pill(
                        text: getStatusLabel(),
                        bg: getStatusColor().withOpacity(0.15),
                        fg: getStatusColor(),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.grey),
                  onPressed: onEdit,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // BLOCO DE INFORMAÇÕES — força alinhamento à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded( // ocupa a largura do card, mas conteúdo fica à esquerda
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoLine(label: "Estoque atual", value: "$currentStock $unit"),
                        _InfoLine(label: "Por cesta", value: "$stockPerBasket $unit"),
                        _InfoLine(label: "Cestas possíveis", value: "$possibleBaskets"),
                        _InfoLine(label: "Estoque mínimo", value: "$minStock $unit"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nível de estoque",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "${(percent * 100).round()}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _progressColor(percent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(_progressColor(percent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const _Pill({required this.text, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoLine({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          if (value != null) ...[
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
