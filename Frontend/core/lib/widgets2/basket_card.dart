import 'package:core/features/family/data/models/family_model.dart';
import 'package:flutter/material.dart';
import 'package:core/features/basket/data/model/basket_model.dart';

class BasketCard extends StatelessWidget {
  final BasketModel basket;
  final FamilyModel family;

  const BasketCard({super.key, required this.basket, required this.family});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.shopping_basket, size: 32, color: Colors.orange),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.name, // ← agora mostra o nome
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${basket.products?.length ?? 0} produtos",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
