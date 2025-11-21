import 'package:flutter/material.dart';

class SegmentedCardSwitcher extends StatefulWidget {
  final List<Widget> options;
  final List<IconData> icons;
  final List<String>? labels;
  final void Function(int index)? onTap;

  const SegmentedCardSwitcher({
    super.key,
    required this.options,
    required this.icons,
    this.labels,
    this.onTap,
  }) : assert(
          options.length == icons.length,
          'options e icons devem ter o mesmo tamanho',
        );

  @override
  State<SegmentedCardSwitcher> createState() => _SegmentedCardSwitcherState();
}

class _SegmentedCardSwitcherState extends State<SegmentedCardSwitcher> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasLabels = widget.labels != null && widget.labels!.length == widget.icons.length;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final double itemWidth = constraints.maxWidth / widget.icons.length;

            return Container(
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Fundo branco animado deslizando
                  AnimatedAlign(
                    alignment: Alignment(-1 + (2 / (widget.icons.length - 1)) * selectedIndex, 0),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: itemWidth,
                      height: 42,
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
                            blurRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Ícones e textos
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(widget.icons.length, (index) {
                      final bool isSelected = index == selectedIndex;

                      return Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() => selectedIndex = index);
                            widget.onTap?.call(index);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(
                                  color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.outline,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      widget.icons[index],
                                      size: 20,
                                      color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.outline,
                                    ),
                                    if (hasLabels) ...[
                                      const SizedBox(width: 6),
                                      Text(
                                        widget.labels![index],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: widget.options[selectedIndex],
        ),
      ],
    );
  }
}
