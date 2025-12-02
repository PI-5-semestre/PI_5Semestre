import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BasketCardSkeleton extends StatelessWidget {
  const BasketCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: theme.colorScheme.surfaceContainerHighest,
              highlightColor: theme.colorScheme.surfaceContainerHighest
                  .withOpacity(0.5),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: theme.colorScheme.surfaceContainerHighest,
                    highlightColor: theme.colorScheme.surfaceContainerHighest
                        .withOpacity(0.5),
                    child: Container(
                      width: 150,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Shimmer.fromColors(
                    baseColor: theme.colorScheme.surfaceVariant.withOpacity(
                      0.3,
                    ),
                    highlightColor: theme.colorScheme.surfaceVariant
                        .withOpacity(0.6),
                    child: Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
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
