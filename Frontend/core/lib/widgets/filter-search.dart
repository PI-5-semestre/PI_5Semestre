import 'package:flutter/material.dart';

class FilterSearch extends StatefulWidget {
  final List<String> categories; // <- categorias recebidas de fora
  final void Function(String searchTerm, String category)? onChanged;

  const FilterSearch({
    super.key,
    required this.categories,
    this.onChanged,
  });

  @override
  State<FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  String searchTerm = "";
  String selectedCategory = "all";

  @override
  void initState() {
    super.initState();

    // garante que "all" sempre exista
    if (!widget.categories.contains("all")) {
      widget.categories.insert(0, "all");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Campo de busca
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Buscar produtos...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green, width: 1.5),
            ),
          ),
          onChanged: (value) {
            setState(() => searchTerm = value);
            widget.onChanged?.call(searchTerm, selectedCategory);
          },
        ),

        const SizedBox(height: 12),

        /// Dropdown de categorias
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: widget.categories.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(
                    c == "all" ? "Todas as categorias" : c,
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => selectedCategory = val!);
                widget.onChanged?.call(searchTerm, selectedCategory);
              },
            ),
          ),
        ),
      ],
    );
  }
}
