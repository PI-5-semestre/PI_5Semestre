import 'package:flutter/material.dart';

class SegmentedCardSwitcher extends StatefulWidget {
  final List<Widget> options;
  final List<String> labels;

  const SegmentedCardSwitcher({
    super.key,
    required this.options,
    required this.labels,
  }) : assert(options.length == labels.length, 'Options e labels devem ter o mesmo tamanho');

  @override
  State<SegmentedCardSwitcher> createState() => _SegmentedCardSwitcherState();
}

class _SegmentedCardSwitcherState extends State<SegmentedCardSwitcher> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: SegmentedButton<int>(
            segments: List.generate(widget.labels.length, (index) {
              return ButtonSegment<int>(
                value: index,
                label: Center(
                  child: Text(widget.labels[index]),
                ),
              );
            }),
            selected: {selectedIndex},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                selectedIndex = newSelection.first;
              });
            },
            showSelectedIcon: false,
          ),
        ),

        const SizedBox(height: 16),

        widget.options[selectedIndex],
      ],
    );
  }
}
