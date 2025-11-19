import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StatCardSkeleton extends StatelessWidget {
  const StatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone com fundo simulando o gradient
            Shimmer.fromColors(
              baseColor: theme.colorScheme.surfaceContainerHighest,
              highlightColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Textos (titulo e valor)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Linha do título
                  Shimmer.fromColors(
                    baseColor:
                        theme.colorScheme.surfaceContainerHighest,
                    highlightColor:
                        theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                    child: Container(
                      height: 16,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Linha do valor
                  Shimmer.fromColors(
                    baseColor:
                        theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    highlightColor:
                        theme.colorScheme.surfaceVariant.withOpacity(0.6),
                    child: Container(
                      height: 22,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                    ),
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
