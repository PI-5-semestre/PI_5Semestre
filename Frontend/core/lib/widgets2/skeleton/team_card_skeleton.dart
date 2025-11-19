import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeamCardSkeleton extends StatelessWidget {
  const TeamCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ---- Nome (lado esquerdo)
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: theme.colorScheme.surfaceContainerHighest,
                  highlightColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  child: Container(
                    height: 18,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // ---- Chip skeleton (lado direito)
              Shimmer.fromColors(
                baseColor: theme.colorScheme.surfaceContainerHighest,
                highlightColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                child: Container(
                  height: 22,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
