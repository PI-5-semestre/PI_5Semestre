import 'package:flutter/material.dart';

class BasketSelectedFamiliesModal extends StatelessWidget {
  final List<String> selectedFamilies;
  final Map<String, double> familyIncome;
  final Map<String, String> basketSizeByFamily;
  final List<String> basketSizes;

  final void Function(String familyName, String newSize) onSizeChanged;
  final VoidCallback onSave;
  final Widget Function(BuildContext context, String familyName)
  buildEditButton;

  const BasketSelectedFamiliesModal({
    Key? key,
    required this.selectedFamilies,
    required this.familyIncome,
    required this.basketSizeByFamily,
    required this.basketSizes,
    required this.onSizeChanged,
    required this.onSave,
    required this.buildEditButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Famílias Selecionadas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: selectedFamilies.isEmpty
                  ? const Center(child: Text("Nenhuma família selecionada."))
                  : SingleChildScrollView(
                      child: Column(
                        children: selectedFamilies.map((name) {
                          final renda = familyIncome[name] ?? 0.0;
                          final currentSize =
                              basketSizeByFamily[name] ?? basketSizes.first;
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Renda: R\$ ${renda.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Tamanho da cesta",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  DropdownButtonFormField<String>(
                                    value: currentSize,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                    ),
                                    items: basketSizes
                                        .map(
                                          (size) => DropdownMenuItem(
                                            value: size,
                                            child: Text(size),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) {
                                      if (v == null) return;
                                      onSizeChanged(name, v);
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  buildEditButton(context, name),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: selectedFamilies.isEmpty ? null : onSave,
                    icon: const Icon(Icons.save),
                    label: const Text("Salvar cestas"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
