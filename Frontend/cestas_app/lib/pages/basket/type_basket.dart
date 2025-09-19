import 'package:flutter/material.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/rendering.dart';

class TypeBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth > 800
            ? 250.0
            : constraints.maxWidth * 0.9;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: cardWidth,
              child: StatCard(
                icon: Icons.shopping_basket,
                colors: [Colors.green, Colors.lightGreen],
                title: 'Cesta Pequena',
                value: '1-3 pessoas\nConfig.: 4 - Cap. máx: 8',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: StatCard(
                icon: Icons.shopping_basket,
                colors: [Colors.blue, Colors.lightBlue],
                title: 'Cesta Média',
                value: '3-4 pessoas\nConfig.: 6 - Cap. máx: 12',
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: StatCard(
                icon: Icons.shopping_basket,
                colors: [Colors.orange, Colors.deepOrange],
                title: 'Cesta Grande',
                value: '5+ pessoas\nConfig.: 8 - Cap. máx: 16',
              ),
            ),
          ],
        );
      },
    );
  }
}
