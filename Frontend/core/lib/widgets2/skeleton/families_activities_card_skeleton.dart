import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FamiliesActivitiesCardSkeleton extends StatelessWidget {
  const FamiliesActivitiesCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: theme.colorScheme.surfaceContainerHighest,
                    highlightColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.6),
                    child: Container(
                      height: 18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: theme.colorScheme.surfaceContainerHighest,
                    highlightColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.6),
                    child: Container(
                      height: 20,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// ÍCONE DA SETA
            Shimmer.fromColors(
              baseColor: theme.colorScheme.surfaceContainerHighest,
              highlightColor: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.6),
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
